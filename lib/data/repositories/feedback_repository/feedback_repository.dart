import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/Feedback/model/feedback_model.dart';

class FeedbackRepository {
  final _db = FirebaseFirestore.instance;

  Future<void> submitFeedback(FeedbackModel model) async {
    await _db.collection('feedback').add(model.toMap());
  }

  Future<List<FeedbackModel>> getUserFeedback(String userId) async {
    final snapshot = await _db
        .collection('feedback')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => FeedbackModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
