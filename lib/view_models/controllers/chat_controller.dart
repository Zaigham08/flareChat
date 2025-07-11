import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_chat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/message_model.dart';

class ChatController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser!.uid;
  Timer? _typingTimer;
  final RxSet<String> selectedChatIds = <String>{}.obs;
  final RxSet<String> selectedMessageIds = <String>{}.obs;
  RxBool isOtherTyping = false.obs;
  RxBool msgSelectionMode = false.obs, chatSelectionMode = false.obs;

  String getChatId(String otherUserId) {
    final ids = [currentUserId, otherUserId]..sort();
    return ids.join('_');
  }

  Stream<List<Message>> getMessages(String otherUserId) {
    final chatId = getChatId(otherUserId);
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => Message.fromMap(doc.data(), doc.id))
                  .toList(),
        );
  }

  Future<void> sendMessage(String text, String otherUserId) async {
    final chatId = getChatId(otherUserId);
    final timestamp = DateTime.now();

    final message = Message(
      senderId: currentUserId,
      text: text,
      timestamp: timestamp,
      seen: false,
    );

    // 1. Save message
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());

    // Fetch current user name
    final currentUserDoc =
        await _firestore.collection('users').doc(currentUserId).get();
    final currentUserName = currentUserDoc['name'];

    // Fetch other user name
    final otherUserDoc =
        await _firestore.collection('users').doc(otherUserId).get();
    final otherUserName = otherUserDoc['name'];

    // 2. Update chat summary (with userInfo embedded)
    await _firestore.collection('chat_summaries').doc(chatId).set({
      'lastMessage': message.text,
      'lastSenderId': currentUserId,
      'lastTimestamp': Timestamp.fromDate(timestamp),
      'participants': [currentUserId, otherUserId],
      'userInfo': {
        currentUserId: {'name': currentUserName},
        otherUserId: {'name': otherUserName},
      },
      "typingStatus": {currentUserId: false, otherUserId: false},
    }, SetOptions(merge: true));

    // Reset typing status
    await _firestore.collection('chat_summaries').doc(chatId).update({
      'typingStatus.$currentUserId': false,
    });
  }

  // Marks all unseen messages as seen when chat is opened
  Future<void> markMessagesAsSeen(String otherUserId) async {
    final chatId = getChatId(otherUserId);
    final messagesRef = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    final unseenSnapshot =
        await messagesRef
            .where('seen', isEqualTo: false)
            .where('senderId', isEqualTo: otherUserId)
            .get();

    if (unseenSnapshot.docs.isEmpty) return;

    for (var doc in unseenSnapshot.docs) {
      await doc.reference.update({'seen': true});
    }
  }

  // Updates typing status (call on `onChanged`)
  void setTypingStatus({required String otherUserId, required bool isTyping}) {
    final chatId = getChatId(otherUserId);
    final docRef = _firestore.collection('chat_summaries').doc(chatId);

    // Cancel previous timer
    _typingTimer?.cancel();

    if (isTyping) {
      // Set typing = true immediately
      docRef.update({'typingStatus.$currentUserId': true});

      // Start debounce timer to set it back to false after 1 second of inactivity
      _typingTimer = Timer(const Duration(seconds: 1), () {
        docRef.update({'typingStatus.$currentUserId': false});
      });
    } else {
      // Manually set to false if needed (e.g., on send button)
      docRef.update({'typingStatus.$currentUserId': false});
    }
  }

  void listenToTypingStatus(String otherUserId) {
    final chatId = getChatId(otherUserId);

    // If chatting with self, never show "typing..."
    if (currentUserId == otherUserId) {
      isOtherTyping.value = false;
      return;
    }

    FirebaseFirestore.instance
        .collection('chat_summaries')
        .doc(chatId)
        .snapshots()
        .listen((doc) {
          final data = doc.data();
          if (data != null) {
            final typingMap =
                data['typingStatus'] as Map<String, dynamic>? ?? {};
            isOtherTyping.value = typingMap[otherUserId] == true;
          }
        });
  }

  Future<void> deleteMessages(String otherUserId) async {
    if (selectedMessageIds.isEmpty) return;
    try {
      final chatId = getChatId(otherUserId);
      final batch = _firestore.batch();
      for (final id in selectedMessageIds) {
        final docRef = _firestore
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .doc(id);
        batch.delete(docRef);
      }
      await batch.commit();
    } catch (e) {
      debugPrint("🔥 Error deleting messages: $e");
      Utils.toastMsg(e.toString());
    } finally {
      msgSelectionMode.value = false;
      selectedMessageIds.clear();
    }
  }

  Future<void> deleteChat() async {
    if (selectedChatIds.isEmpty) return;

    try {
      Utils.showSimpleLoading();
      for (final chatId in selectedChatIds) {
        // 1. Delete messages in subCollection
        final messages =
            await _firestore
                .collection('chats')
                .doc(chatId)
                .collection('messages')
                .get();

        for (final doc in messages.docs) {
          await doc.reference.delete();
        }

        // 2. Delete chat summary
        await _firestore.collection('chat_summaries').doc(chatId).delete();
      }
      Utils.dismissLoadingDialog();
    } catch (e) {
      debugPrint("🔥 Error deleting chats: $e");
      Utils.toastMsg("Error deleting chats: ${e.toString()}");
    } finally {
      chatSelectionMode.value = false;
      selectedChatIds.clear();
    }
  }
}
