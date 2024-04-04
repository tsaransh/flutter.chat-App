import 'package:flutter/material.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewChatState();
  }
}

class _NewChatState extends State<NewChat> {
  var messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final message = messageController.text;
    if (message.trim().isEmpty) {
      return;
    }

    // sending message

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration:
                  const InputDecoration(labelText: 'enter your message here!'),
            ),
          ),
          IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
