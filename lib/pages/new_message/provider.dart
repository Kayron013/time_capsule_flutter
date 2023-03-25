import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_capsule_flutter/models/Message.dart';

class NewMessageProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<String> _recipients = [];
  List<String> get recipients => _recipients;

  String _content = '';
  String get content => _content;

  MessageState _state = MessageState.selectRecipients;
  MessageState get state => _state;

  void setRecipients(List<String> recipients) {
    _recipients = recipients;
    _state = MessageState.composeMessage;
    notifyListeners();
    debugPrint('notified listeners after setting recipients');
  }

  void setContent(String content) {
    _content = content;
    _state = MessageState.storingMessage;
    notifyListeners();
    _scheduleMessage();
  }

  Future<void> _scheduleMessage() async {
    var message = Message.init(content: content, recipients: recipients);
    if (_auth.currentUser == null) return;
    try {
      await _db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('messages')
          .doc()
          .set(message.toJson());
      _state = MessageState.storedSuccess;
      notifyListeners();
    } catch (error) {
      _state = MessageState.storedFailure;
      notifyListeners();
    }
  }
}

enum MessageState {
  selectRecipients,
  composeMessage,
  storingMessage,
  storedSuccess,
  storedFailure
}
