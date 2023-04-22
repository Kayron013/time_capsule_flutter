import { FirestoreDataConverter } from 'firebase-admin/firestore';
import { MessageStatus } from 'twilio/lib/rest/api/v2010/account/message';

export interface Message {
  id: string;
  content: string;
  createdAt: number;
  isSent: boolean;
  recipient: string;
  scheduledDelivery: number;
  type: MessageType;
  twilioMessageSid: string;
  twilioMessageStatus: MessageStatus;
}

type MessageType = 'sms';

export const messageConverter: FirestoreDataConverter<Message> = {
  toFirestore: message => message,
  fromFirestore(snapshot) {
    return snapshot.data() as Message;
  },
};
