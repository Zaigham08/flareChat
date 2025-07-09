import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/message_model.dart';

class ChatController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser!.uid;

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
              snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList(),
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

    final unseen =
        await messagesRef
            .where('seen', isEqualTo: false)
            .where('senderId', isEqualTo: otherUserId)
            .get();

    for (var doc in unseen.docs) {
      await doc.reference.update({'seen': true});
    }
  }

  // Updates typing status (call on `onChanged`)
  Future<void> setTypingStatus({
    required String otherUserId,
    required bool isTyping,
  }) async {
    final chatId = getChatId(otherUserId);
    await _firestore.collection('chat_summaries').doc(chatId).set({
      'typingStatus': {currentUserId: isTyping},
    }, SetOptions(merge: true));
  }
}
