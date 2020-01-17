import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/chat/chat_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/user/user_service.dart';

class FirebaseChatService extends ChatService {
  final Firestore _firestore = Firestore.instance;
  final AuthService _authService = services.get<AuthService>();

  @override
  void sendMessage(String toUid, String message) async {
    ChatMessage myChatMessage = ChatMessage(
      message: message,
      sentByMe: true,
    );

    ChatMessage recipientChatMessage = ChatMessage(
      message: message,
      sentByMe: false,
    );

    await _firestore
        .collection("chats")
        .document(_authService.currentUserUid)
        .collection(toUid)
        .add(myChatMessage.toJson());

    await _firestore
        .collection("chats")
        .document(toUid)
        .collection(_authService.currentUserUid)
        .add(recipientChatMessage.toJson());
  }

  @override
  Stream<QuerySnapshot> getChatStream(String uid) {
    return _firestore
        .collection("chats")
        .document(_authService.currentUserUid)
        .collection(uid)
        .orderBy("date_sent", descending: true)
        .snapshots();
  }

  @override
  Future<List<Future<User>>> getChattedUsers() async {
    UserService _userService = services.get<UserService>();
    final snapshot = await _firestore
        .collection("users")
        .document(_authService.currentUserUid)
        .get();
    if (snapshot != null) {
      List<String> stringList = List.from(snapshot.data['conversations']);
      List<Future<User>> users =
          stringList.map((uid) => _userService.getUser(uid)).toList();

      Future<User> a = _userService.getUser(_authService.currentUserUid);
      User b;
      a.then((User v)=>b=v);

      List<User> u;
      Future.wait(users).then((List<User> values) => u = values);

      return stringList.map((uid) => _userService.getUser(uid)).toList();
    }

    return null;
  }
}
