import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/widgets/chat_message_widget.dart';

class ChatMessageList extends StatelessWidget {
  final Stream<QuerySnapshot> messageStream;
  final User correspondent;
  final _scrollController = ScrollController(initialScrollOffset: 0);

  ChatMessageList({Key key, this.messageStream, this.correspondent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreAnimatedList(
        controller: _scrollController,
        reverse: true,
        query: messageStream,
        itemBuilder: (context, snapshot, animation, index) {
          if (snapshot.data != null) {
            if (index != 0) {
              _scrollController
                  .jumpTo(_scrollController.position.minScrollExtent);
            }
            final chatMessage = ChatMessage.fromJson(snapshot.data);
            return ScaleTransition(
              alignment: chatMessage.sentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              scale: animation,
              child: ChatMessageWidget(
                correspondentName: correspondent.username,
                chatMessage: chatMessage,
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
