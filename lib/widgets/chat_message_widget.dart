import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage chatMessage;

  const ChatMessageWidget({
    Key key,
    this.chatMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
      chatMessage.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (chatMessage.sentByMe) Expanded(
            flex: 1,
            child: Container(),
          ), // make the message half the size of the row
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                10,
                10,
                10,
                0,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  color: chatMessage.sentByMe ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                chatMessage.message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          if (chatMessage.sentByMe == false) Expanded(
            flex: 1,
            child: Container(),
          ), // make the message half the size of the row
        ],
      ),
    );
  }
}