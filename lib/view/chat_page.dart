import 'package:flare_chat/res/constants.dart';
import 'package:flare_chat/res/widgets/input%20field%20components/my_text_input_field.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../res/widgets/general widgets/my_text.dart';
import '../view_models/controllers/chat_controller.dart';

class ChatPage extends StatefulWidget {
  final String otherUserId;
  final String otherUserName;

  const ChatPage({
    super.key,
    required this.otherUserId,
    required this.otherUserName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _chatController = ChatController();
  final _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatController.markMessagesAsSeen(widget.otherUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: MyText(widget.otherUserName, color: whiteColor)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatController.getMessages(widget.otherUserId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: btnColor),
                  );
                }
                final messages = snapshot.data!;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.senderId == _chatController.currentUserId;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: ChatWidget(isMe: isMe, msg: msg),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextInputField(
                    controller: _msgController,
                    hintText: "Type a message...",
                    textCapitalization: TextCapitalization.sentences,
                    onFieldSubmitted: (_) {
                      final text = _msgController.text.trim();
                      if (text.isNotEmpty) {
                        _chatController.sendMessage(text, widget.otherUserId);
                        _msgController.clear();
                        _chatController.markMessagesAsSeen(widget.otherUserId);
                      }
                    },
                    onChanged: (value) {
                      _chatController.setTypingStatus(
                        otherUserId: widget.otherUserId,
                        isTyping: value.trim().isNotEmpty,
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: btnColor, size: 28),
                  onPressed: () {
                    final text = _msgController.text.trim();
                    if (text.isNotEmpty) {
                      _chatController.sendMessage(text, widget.otherUserId);
                      _msgController.clear();
                      _chatController.markMessagesAsSeen(widget.otherUserId);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.isMe, required this.msg});

  final bool isMe;
  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFDCF8C6) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(msg.text, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(msg.timestamp),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    msg.seen
                        ? Icons.done_all
                        : Icons.done, // double tick for seen
                    size: 16,
                    color: msg.seen ? Colors.blue : Colors.grey,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
