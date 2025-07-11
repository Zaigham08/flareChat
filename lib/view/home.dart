import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_chat/res/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/widgets/general widgets/my_text.dart';
import '../utils/utils.dart';
import '../view_models/controllers/auth_controller.dart';
import '../view_models/controllers/chat_controller.dart';
import 'all_users_page.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final authController = Get.find<AuthController>();
    final chatController = Get.put(ChatController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }
        if (chatController.chatSelectionMode.value) {
          // Exit selection mode instead of popping the page
          chatController.chatSelectionMode.value = false;
          chatController.selectedChatIds.clear();
        } else {
          Get.back();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const MyText("FlareChat", color: whiteColor),
          actions: [
            Obx(() {
              return chatController.chatSelectionMode.value
                  ? IconButton(
                    icon: const Icon(
                      CupertinoIcons.delete,
                      color: whiteColor,
                      size: 22,
                    ),
                    onPressed: () {
                      final selectedChatLength =
                          chatController.selectedChatIds.length;
                      Utils.showConfirmationDialog(
                        title: "Are you sure?",
                        text:
                            selectedChatLength == 1
                                ? "Delete this chat?"
                                : "Delete $selectedChatLength chats?",
                        btnText: "Delete",
                        onTap: () async {
                          await chatController.deleteChat();
                        },
                      );
                    },
                  )
                  : IconButton(
                    onPressed: () {
                      Utils.showConfirmationDialog(
                        title: "Are you sure?",
                        text: logoutString,
                        btnText: "Logout",
                        onTap: authController.logout,
                      );
                    },
                    icon: const Icon(Icons.logout, color: whiteColor),
                  );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const Icon(Icons.message, color: Colors.white),
          onPressed: () {
            Get.to(() => const AllUsersPage()); // We'll build this next
          },
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection('chat_summaries')
                  .where('participants', arrayContains: currentUserId)
                  .orderBy('lastTimestamp', descending: true)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            if (snapshot.hasError) {
              debugPrint(
                "Firestore chat_summaries stream error: ${snapshot.error}",
              );
              return const Center(child: Text("Error loading chats"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No chats yet. Tap below to start chatting."),
              );
            }

            final chats = snapshot.data!.docs;

            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                final participants = List<String>.from(chat['participants']);
                final otherUserId = participants.firstWhere(
                  (id) => id != currentUserId,
                  orElse: () => currentUserId, // fallback for self-chat
                );
                final lastMsg = chat['lastMessage'] ?? '';
                final lastTimestamp =
                    (chat['lastTimestamp'] as Timestamp).toDate();
                final isSelf = otherUserId == currentUserId;

                final userInfo =
                    chat['userInfo'] as Map<String, dynamic>? ?? {};
                final otherUserData = userInfo[otherUserId] ?? {};
                final otherUserName = otherUserData['name'];
                final displayName =
                    isSelf ? "$otherUserName (You)" : otherUserName;
                final typingStatus =
                    chat['typingStatus'] as Map<String, dynamic>? ?? {};
                final isOtherTyping = typingStatus[otherUserId] == true;

                return Obx(
                  () => buildChatWidget(
                    displayName,
                    isOtherTyping,
                    lastMsg,
                    lastTimestamp,
                    chatController,
                    chat,
                    otherUserId,
                    otherUserName,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Container buildChatWidget(
    displayName,
    bool isOtherTyping,
    lastMsg,
    DateTime lastTimestamp,
    ChatController chatController,
    QueryDocumentSnapshot<Object?> chat,
    String otherUserId,
    otherUserName,
  ) {
    final isSelected = chatController.selectedChatIds.contains(chat.id);
    return Container(
      color: isSelected ? btnColor.withValues(alpha: 0.26) : null,
      child: ListTile(
        leading: Stack(
          children: [
            const Icon(CupertinoIcons.profile_circled, size: 45),
            if (isSelected)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: btnColor,
                  ),
                  child: Icon(Icons.done, size: 15, color: blackColor),
                ),
              ),
          ],
        ),
        title: Text(displayName),
        subtitle: Text(
          isOtherTyping ? "Typing..." : lastMsg,
          style: TextStyle(
            fontStyle: isOtherTyping ? FontStyle.italic : FontStyle.normal,
            color: isOtherTyping ? Colors.green : null,
          ),
        ),
        trailing: Text(formatTimeAgo(lastTimestamp)),
        onTap: () {
          if (chatController.chatSelectionMode.value) {
            chatController.selectedChatIds.contains(chat.id)
                ? chatController.selectedChatIds.remove(chat.id)
                : chatController.selectedChatIds.add(chat.id);
            if (chatController.selectedChatIds.isEmpty) {
              chatController.chatSelectionMode.value = false;
            }
          } else {
            Get.to(
              () => ChatPage(
                otherUserId: otherUserId,
                otherUserName: otherUserName,
              ),
            );
          }
        },
        onLongPress: () {
          chatController.chatSelectionMode.value = true;
          chatController.selectedChatIds.add(chat.id);
        },
      ),
    );
  }

  String formatTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'Now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}
