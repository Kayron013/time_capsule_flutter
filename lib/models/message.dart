import 'dart:math';

class Message {
  String id;
  String content;
  DateTime createdAt;
  bool isSent;
  String recipient;
  DateTime scheduledDelivery;
  MessageType type;
  String? twilioMessageSid;
  MessageStatus? twilioMessageStatus;

  Message(
      {required this.id,
      required this.content,
      required this.createdAt,
      required this.isSent,
      required this.recipient,
      required this.scheduledDelivery,
      required this.type,
      required this.twilioMessageSid,
      required this.twilioMessageStatus});

  static Message fromJson(Map json) {
    return Message(
        id: json['id'],
        content: json['content'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        isSent: json['isSent'],
        recipient: json['recipient'],
        scheduledDelivery:
            DateTime.fromMillisecondsSinceEpoch(json['scheduledDelivery']),
        type: MessageType.values.byName(json['type']),
        twilioMessageSid: json['twilioMessageSid'],
        twilioMessageStatus: json['twilioMessageStatus'] == null
            ? null
            : MessageStatus.values.byName(json['twilioMessageStatus']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isSent': isSent,
      'recipient': recipient,
      'scheduledDelivery': scheduledDelivery.millisecondsSinceEpoch,
      'type': type.name,
      'twilioMessageSid': twilioMessageSid,
      'twilioMessageStatus': twilioMessageStatus?.name
    };
  }

  static Message init(
      {required String id,
      required String content,
      required String recipient}) {
    Random gen = Random();
    int range = 24 * 365 * 5; // 5 years in hours
    var scheduledDelivery =
        DateTime.now().add(Duration(hours: gen.nextInt(range) + 1));

    return Message(
        id: id,
        content: content,
        createdAt: DateTime.now(),
        isSent: false,
        recipient: recipient,
        scheduledDelivery: scheduledDelivery,
        type: MessageType.sms,
        twilioMessageSid: null,
        twilioMessageStatus: null);
  }
}

enum MessageType { sms }

enum MessageStatus {
  queued,
  sending,
  sent,
  failed,
  delivered,
  undelivered,
  receiving,
  received,
  accepted,
  scheduled,
  read,
  // ignore: constant_identifier_names
  partially_delivered,
  canceled,
}
