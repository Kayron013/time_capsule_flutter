import 'dart:math';

// TODO: storing twilio message info per recipient
class Message {
  String content;
  DateTime createdAt;
  bool isDelivered;
  List<String> recipients;
  DateTime scheduledDelivery;
  MessageType type;
  String? twilioMessageSid;
  MessageStatus? twilioMessageStatus;

  Message(
      {required this.content,
      required this.createdAt,
      required this.isDelivered,
      required this.recipients,
      required this.scheduledDelivery,
      required this.type,
      required this.twilioMessageSid,
      required this.twilioMessageStatus});

  static Message fromJson(Map json) {
    return Message(
        content: json['content'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        isDelivered: json['isDelivered'],
        recipients: json['recipients'],
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
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isDelivered': isDelivered,
      'recipients': recipients,
      'scheduledDelivery': scheduledDelivery.millisecondsSinceEpoch,
      'type': type.name,
      'twilioMessageSid': twilioMessageSid,
      'twilioMessageStatus': twilioMessageStatus?.name
    };
  }

  static Message init(
      {required String content, required List<String> recipients}) {
    Random gen = Random();
    int range = 24 * 365 * 5; // 5 years in hours
    var scheduledDelivery =
        DateTime.now().add(Duration(hours: gen.nextInt(range) + 1));

    return Message(
        content: content,
        createdAt: DateTime.now(),
        isDelivered: false,
        recipients: recipients,
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
