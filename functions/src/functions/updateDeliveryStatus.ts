import express from 'express';
import cors from 'cors';
import { MessageStatus } from 'twilio/lib/rest/api/v2010/account/message';
import { firestore, functions, logger } from '../services/firebase';
import { messageConverter } from '../models';

const app = express();

app.use(cors({ origin: true }));

app.use(express.urlencoded({ extended: true }));

/**
 * Callback webhook for delivery status of message sent via Twilio
 */
app.post('/sms/status', async (req, res) => {
  const messageSid = (req.body.MessageSid || '').trim() as string;
  const messageStatus = (req.body.MessageStatus || '').trim() as MessageStatus;
  const messageId = req.query.messageId as string;

  logger.log('Status update recieved', {
    messageSid: messageSid,
    messageStatus: messageStatus,
  });

  if (!messageId) {
    const errorMessage = 'You must pass a messageId queryParam';
    res.status(400).json({ errorMessage });
    return;
  }

  if (messageSid == '' || messageStatus.length == 0) {
    res.status(400).json('MessageSid and MessageStatus cannot be empty');
    return;
  }

  const collSnapshot = await firestore
    .collectionGroup('messages')
    .where('id', '==', messageId)
    .withConverter(messageConverter)
    .get();

  if (collSnapshot.empty) {
    const errorMessage =
      'Did not find a scheduled message for the message status update';

    logger.error(errorMessage, { messageSid, messageStatus });
    res.status(404).json({ errorMessage });
    return;
  }

  const ref = collSnapshot.docs[0].ref;

  await firestore.runTransaction(async t => {
    const doc = await t.get(ref);

    // Don't overwrite 'delivered' if 'sent' is processed afterwards
    // Callback events: https://support.twilio.com/hc/en-us/articles/223134347-What-are-the-Possible-SMS-and-MMS-Message-Statuses-and-What-do-They-Mean-
    const message = doc.data();

    if (!message) {
      const error = `Couldn't find message ID=${ref.id}`;
      console.error(error);
      res.status(500).json({ error });
      return;
    }

    if (message.twilioMessageStatus == 'delivered') {
      logger.info(
        `Not updating status because current status is ${message.twilioMessageStatus} and incomming status is ${messageStatus}`
      );
      return;
    }

    t.update(ref, {
      twilioMessageSid: messageSid,
      twilioMessageStatus: messageStatus,
      isSent: true,
    });
  });

  if (collSnapshot.docs.length > 1) {
    const messageIds = collSnapshot.docs.map(doc => doc.id).join(',');
    logger.error(
      'Found more than one scheduled message with the same message sid',
      {
        messageSid,
        messageStatus,
        messageIds,
      }
    );
  }

  res.sendStatus(200);
});

export const updateDeliveryStatus = functions.https.onRequest(app);
