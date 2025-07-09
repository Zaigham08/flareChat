import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_chat/res/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/widgets/general widgets/my_text.dart';
import 'chat_page.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: MyText("Select User", color: whiteColor)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs.toList();

          if (users.isEmpty) {
            return const Center(child: Text("No users available"));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final isSelf = user.id == currentUserId;
              return ListTile(
                leading: const Icon(CupertinoIcons.person_circle, size: 46),
                title: Text(user['name'] + (isSelf ? " (You)" : "")),
                subtitle: Text(isSelf ? "Tap to chat with yourself" : ""),
                onTap: () {
                  Get.to(
                    () => ChatPage(
                      otherUserId: user.id,
                      otherUserName: user['name'],
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
}
