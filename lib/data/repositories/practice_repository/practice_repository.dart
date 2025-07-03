import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/best_practices_and_sessions/module/practice_model.dart';
import '../../../features/best_practices_and_sessions/module/session_model.dart';

class PracticeRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<PracticeModel>> getPracticesByProblem(String problemId) async {
    final snapshot = await _db
        .collection('practices')
        .where('problemId', isEqualTo: problemId)
        .get();
    return snapshot.docs.map((doc) => PracticeModel.fromMap(doc.data(), doc.id)).toList();
  }

  Future<List<SessionModel>> getSessionsByProblem(String problemId) async {
    final snapshot = await _db
        .collection('sessions')
        .where('problemId', isEqualTo: problemId)
        .get();
    return snapshot.docs.map((doc) => SessionModel.fromMap(doc.data(), doc.id)).toList();
  }
}
