import { MessageStatus } from 'twilio/lib/rest/api/v2010/account/message';

// TODO: storing twilio message info per recipient
export interface Message {
  content: string;
  createdAt: number;
  isDelivered: boolean;
  recipients: string[];
  scheduledDelivery: number;
  type: MessageType;
  twilioMessageSid: string;
  twilioMessageStatus: MessageStatus;
}

type MessageType = 'sms';
