import functions from 'firebase-functions';
import env from '../env';
import { Message } from '../models';
import { firestore } from '../services/firebase';
import twilio from '../services/twilio';

/**
 * Deliver all undelivered messaged, scheduled to be delivered in the past
 */
export const sendScheduledMessages = functions.pubsub.schedule('every 30 minutes').onRun(async context => {
  const now = Date.now();
  const collSnapshot = await firestore
    .collectionGroup('messages')
    .where('isDelivered', '==', false)
    .where('scheduledDelivery', '<=', now)
    .get();

  Promise.allSettled(
    collSnapshot.docs
      .map(async docSnapshot => {
        const ref = docSnapshot.ref;
        const doc = docSnapshot.data() as Message;

        return doc.recipients.map(async recipient => {
          const res = await twilio.messages.create({
            to: recipient,
            from: env.TWILIO_NUMBER,
            body: doc.content,
            statusCallback: '',
          });

          ref.update({
            twilioMessageSid: res.sid,
            twilioMessageStatus: res.status,
          } as Partial<Message>);

          console.log(`Message sent MessageSid: ${res.sid}}`);
        });
      })
      .flat()
  );
});
