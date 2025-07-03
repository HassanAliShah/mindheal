import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/Progress_tracking/model/progress_model.dart';

class ProgressRepository {
  final _db = FirebaseFirestore.instance;

  Future<void> markCompleted(ProgressModel model) async {
    await _db.collection('progress').add(model.toMap());
  }

  Future<List<ProgressModel>> getUserProgress(String userId) async {
    final snapshot = await _db
        .collection('progress')
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => ProgressModel.fromMap(doc.data(), doc.id)).toList();
  }

  Future<bool> isItemCompleted(String userId, String itemId) async {
    final snapshot = await _db
        .collection('progress')
        .where('userId', isEqualTo: userId)
        .where('itemId', isEqualTo: itemId)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }
}
