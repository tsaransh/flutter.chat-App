import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Lets Chat'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(),
            ),
            NewChat()
          ],
        ),
      ),
    );
  }
}
