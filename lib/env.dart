import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String env = dotenv.get('ENV', fallback: 'DEV');
}
