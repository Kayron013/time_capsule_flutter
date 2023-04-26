import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_capsule_flutter/firebase_options.dart';
import 'package:time_capsule_flutter/models/Message.dart';

abstract class DataProvider<T> extends ChangeNotifier {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  final Query<T> _query;

  DataProvider(this._query) {
    _query.get().then(
      (value) {
        _data = value.docs.map((e) => e.data()).toList();
        debugPrint(_data.toString());
        notifyListeners();
      },
    );
  }

  List<T>? _data;
  List<T>? get data => _data;
}

class MessageProvider extends DataProvider<Message> {
  MessageProvider(super.query);

  static MessageProvider recentScheduled() {
    var query = DataProvider._db
        .doc('users/${DataProvider._auth.currentUser!.uid}')
        .collection('messages')
        .where('isSent', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .withConverter<Message>(
            fromFirestore: (doc, _) => Message.fromJson(doc.data()!),
            toFirestore: (msg, _) => msg.toJson());

    return MessageProvider(query);
  }

  static MessageProvider recentSent() {
    var query = DataProvider._db
        .doc('users/${DataProvider._auth.currentUser!.uid}')
        .collection('messages')
        .where('isSent', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .withConverter<Message>(
            fromFirestore: (doc, _) => Message.fromJson(doc.data()!),
            toFirestore: (msg, _) => msg.toJson());

    return MessageProvider(query);
  }
}
