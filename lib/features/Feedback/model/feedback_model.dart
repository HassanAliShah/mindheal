import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String id;
  final String userId;
  final String? itemId;
  final String itemType; // e.g., 'practice', 'session', 'appointment', 'general'
  final String message;
  final int? rating;
  final DateTime createdAt;

  FeedbackModel({
    required this.id,
    required this.userId,
    this.itemId,
    required this.itemType,
    required this.message,
    this.rating,
    required this.createdAt,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> data, String id) {
    return FeedbackModel(
      id: id,
      userId: data['userId'],
      itemId: data['itemId'],
      itemType: data['itemType'],
      message: data['message'],
      rating: data['rating'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'itemId': itemId,
    'itemType': itemType,
    'message': message,
    'rating': rating,
    'createdAt': createdAt,
  };
}
