import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/model/user.dart';

abstract class ChatService {
  void sendMessage(String toUid, String message);

  Stream<QuerySnapshot> getChatStream(String uid);

  Future<List<Future<User>>> getChattedUsers();
}
