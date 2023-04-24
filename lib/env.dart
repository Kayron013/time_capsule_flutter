import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String twilioAccountSid = dotenv.get('TWILIO_ACCOUNT_SID');
  static String twilioAuthToken = dotenv.get('TWILIO_AUTH_TOKEN');
}
