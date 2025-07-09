import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_chat/res/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/widgets/general widgets/my_text.dart';
import '../utils/utils.dart';
import '../view_models/controllers/auth_controller.dart';
import 'all_users_page.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const MyText("FlareChat", color: whiteColor),
        actions: [
          IconButton(
            onPressed: () {
              Utils.showConfirmationDialog(
                title: "Are you sure?",
                text: logoutString,
                btnText: "Logout",
                onTap: authController.logout,
              );
            },
            icon: const Icon(Icons.logout, color: whiteColor),
          ),
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

              final userInfo = chat['userInfo'] as Map<String, dynamic>? ?? {};
              final otherUserData = userInfo[otherUserId] ?? {};
              final otherUserName = otherUserData['name'];
              final displayName =
                  isSelf ? "$otherUserName (You)" : otherUserName;
              final typingStatus =
                  chat['typingStatus'] as Map<String, dynamic>? ?? {};
              final isOtherTyping = typingStatus[otherUserId] == true;

              return ListTile(
                leading: const Icon(CupertinoIcons.profile_circled, size: 46),
                title: Text(displayName),
                subtitle: Text(
                  isOtherTyping ? "Typing..." : lastMsg,
                  style: TextStyle(
                    fontStyle:
                        isOtherTyping ? FontStyle.italic : FontStyle.normal,
                    color: isOtherTyping ? Colors.green : null,
                  ),
                ),
                trailing: Text(formatTimeAgo(lastTimestamp)),
                onTap: () {
                  Get.to(
                    () => ChatPage(
                      otherUserId: otherUserId,
                      otherUserName: otherUserName,
                    ),
                  );
                },
              );
            },
          );
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
