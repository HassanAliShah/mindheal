import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressModel {
  final String id;
  final String userId;
  final String itemId;
  final String itemType; // 'practice' or 'session'
  final bool completed;
  final DateTime completedAt;

  ProgressModel({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.itemType,
    required this.completed,
    required this.completedAt,
  });

  factory ProgressModel.fromMap(Map<String, dynamic> data, String id) {
    return ProgressModel(
      id: id,
      userId: data['userId'],
      itemId: data['itemId'],
      itemType: data['itemType'],
      completed: data['completed'],
      completedAt: (data['completedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'itemId': itemId,
      'itemType': itemType,
      'completed': completed,
      'completedAt': completedAt,
    };
  }
}
