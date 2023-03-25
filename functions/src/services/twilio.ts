import twilio from 'twilio';
import env from '../env';

export default twilio(env.TWILIO_ACCOUNT_SID, env.TWILIO_AUTH_TOKEN);
