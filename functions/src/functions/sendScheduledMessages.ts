import env from '../env';
import { messageConverter } from '../models';
import { firestore, functions, logger } from '../services/firebase';
import twilio from '../services/twilio';

/**
 * Send all unsent messaged scheduled to be delivered in the past
 */
export const sendScheduledMessages = functions.pubsub
  .schedule('every 30 minutes')
  .onRun(async () => {
    const now = Date.now();
    const collSnapshot = await firestore
      .collectionGroup('messages')
      .where('isSent', '==', false)
      .where('scheduledDelivery', '<=', now)
      .withConverter(messageConverter)
      .get();

    if (collSnapshot.empty) {
      logger.log('No messages found for delivery');
    }

    Promise.allSettled(
      collSnapshot.docs.map(async docSnapshot => {
        const ref = docSnapshot.ref;
        const doc = docSnapshot.data();

        const res = await twilio.messages.create({
          to: doc.recipient,
          from: env.TWILIO_NUMBER,
          body: doc.content,
          statusCallback: `https://us-central1-time-capsule-b9ad2.cloudfunctions.net/updateDeliveryStatus/sms/status?messageId=${doc.id}`,
        });

        // Getting doc again in transaction to ensure we're not overwritting a message status update
        // that arrived before we would write the initial status
        await firestore.runTransaction(async t => {
          const doc = await t.get(ref);

          const message = doc.data();

          if (!message) {
            throw new Error(`Couldn't find message ID=${ref.id}`);
          }

          // Doc was already updated by message status callback
          if (message.twilioMessageStatus != null) {
            logger.log('Doc already updated by message status callback');
            return;
          }

          t.update(ref, {
            twilioMessageSid: res.sid,
            twilioMessageStatus: res.status,
            isSent: true,
          });
        });

        logger.log('Message sent. ', {
          messageSid: res.sid,
          messageStatus: res.status,
        });
      })
    );
  });
