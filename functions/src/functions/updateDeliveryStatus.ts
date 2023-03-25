import functions from 'firebase-functions';
import express from 'express';
import cors from 'cors';
import { MessageStatus } from 'twilio/lib/rest/api/v2010/account/message';
import { firestore } from '../services/firebase';
import { Message } from '../models';

const app = express();

app.use(cors({ origin: true }));

/**
 * Callback webhook for delivery status of message sent via Twilio
 * TODO: storing twilio message info per recipient
 */
app.post('/sms/status', async (req, res) => {
  const messageSid = req.body.MessageSid as string;
  const messageStatus = req.body.MessageStatus as MessageStatus;

  const collSnapshot = await firestore.collectionGroup('messages').where('messageSid', '==', messageSid).get();

  if (collSnapshot.empty) {
    console.error(`Did not find a scheduled message for the message status update. MessageSid: ${messageSid}`);
    res.sendStatus(500);
    return;
  }

  const ref = collSnapshot.docs[0].ref;
  ref.update({
    twilioMessageStatus: messageStatus,
  } as Partial<Message>);

  if (collSnapshot.docs.length > 1) {
    const messageIds = collSnapshot.docs.map(doc => doc.id).join(',');
    console.error(
      `Found more than one scheduled message with the same message sid. MessageSid: ${messageSid} Message IDs: ${messageIds}`
    );
  }

  res.sendStatus(200);
});

export const updateDeliveryStatus = functions.https.onRequest(app);
