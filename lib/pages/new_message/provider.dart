import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_capsule_flutter/models/Message.dart';

class NewMessageProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String _recipient = '';
  String get recipient => _recipient;

  String _content = '';
  String get content => _content;

  MessageState _state = MessageState.selectRecipients;
  MessageState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void setRecipient(String recipient) {
    _recipient = recipient;
    _state = MessageState.composeMessage;
    notifyListeners();
  }

  Future<bool> sendContent(String content) {
    _content = content;
    _state = MessageState.storingMessage;
    _errorMessage = '';
    notifyListeners();
    return _scheduleMessage();
  }

  Future<bool> _scheduleMessage() async {
    if (_auth.currentUser == null) return false;

    var ref = _db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('messages')
        .doc();

    var message =
        Message.init(id: ref.id, content: content, recipient: recipient);

    try {
      await ref.set(message.toJson());
      return true;
    } on FirebaseException catch (error) {
      _state = MessageState.storedFailure;
      _errorMessage = 'Error storing message';
      debugPrint(error.toString());
      notifyListeners();
      return false;
    }
  }
}

enum MessageState {
  selectRecipients,
  composeMessage,
  storingMessage,
  storedFailure
}
