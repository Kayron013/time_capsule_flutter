import 'dart:convert' show base64, utf8, json;

import 'package:http/http.dart' as http;

class Twilio {
  static String baseUrl = 'https://api.twilio.com/2010-04-01';
  final String _authCredentials;

  Twilio(String accountSid, String authToken)
      : _authCredentials = _toAuthCredentials(accountSid, authToken);

  static String _toAuthCredentials(String accountSid, String authToken) {
    return base64.encode(utf8.encode('$accountSid:$authToken'));
  }

  Lookups get lookups => Lookups(_authCredentials);
}

class Lookups {
  static String baseUrl = 'https://lookups.twilio.com/v2/PhoneNumbers';
  final String _authCredentials;

  const Lookups(this._authCredentials);

  Future<Map> phoneNumbers(String phoneNumber) async {
    var client = http.Client();
    var uri = Uri.parse('$baseUrl/$phoneNumber');

    var resp = await client
        .get(uri, headers: {'Authorization': 'Basic $_authCredentials'});
    return json.decode(resp.body);
  }
}
