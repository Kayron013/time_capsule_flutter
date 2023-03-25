import 'dart:math';

class Message {
  String content;
  DateTime createdAt;
  bool isDelivered;
  List<String> recipients;
  DateTime scheduledDelivery;

  Message(
      {required this.content,
      required this.createdAt,
      required this.isDelivered,
      required this.recipients,
      required this.scheduledDelivery});

  static Message fromJson(Map json) {
    return Message(
        content: json['content'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        isDelivered: json['isDelivered'],
        recipients: json['recipients'],
        scheduledDelivery:
            DateTime.fromMillisecondsSinceEpoch(json['scheduledDelivery']));
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isDelivered': isDelivered,
      'recipients': recipients,
      'scheduledDelivery': scheduledDelivery.millisecondsSinceEpoch
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
        scheduledDelivery: scheduledDelivery);
  }
}
