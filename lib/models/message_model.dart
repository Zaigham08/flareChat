import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool seen;

  Message({
    this.id = '',
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.seen,
  });

  factory Message.fromMap(Map<String, dynamic> map, [String id = '']) {
    return Message(
      id: id,
      senderId: map['senderId'],
      text: map['text'],
      seen: map['seen'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'seen': seen,
    };
  }
}
