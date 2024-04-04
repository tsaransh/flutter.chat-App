import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No message found'));
              }

              if (!chatSnapshot.hasData) {
                return const Center(
                    child:
                        Text('Something went wrong, please try again later'));
              }

              final loadedMessage = chatSnapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
                reverse: true,
                itemCount: loadedMessage.length,
                itemBuilder: (ctx, index) {
                  final chatMessage = loadedMessage[index].data();
                  final nextChatMessage = index + 1 < loadedMessage.length
                      ? loadedMessage[index + 1].data()
                      : null;

                  final currentMessageUserID = chatMessage['userId'];
                  final nextMessageUserId = nextChatMessage != null
                      ? nextChatMessage['userId']
                      : null;
                  final nextUserIsSame =
                      nextMessageUserId == currentMessageUserID;

                  if (nextUserIsSame) {
                    return MessageBubble.next(
                        message: chatMessage['text'],
                        isMe: authenticatedUser.uid == currentMessageUserID);
                  } else {
                    return MessageBubble.first(
                        userImage: chatMessage['userImage'],
                        username: chatMessage['username'],
                        message: chatMessage['text'],
                        isMe: authenticatedUser.uid == currentMessageUserID);
                  }
                },
              );
            }));
  }
}
