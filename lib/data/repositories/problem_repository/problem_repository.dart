import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/problemCategory/model/ProblemCategoryModel.dart';

class ProblemRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<ProblemCategoryModel>> fetchCategories() async {
    final snapshot = await _db.collection('problemCategories').get();
    return snapshot.docs.map((doc) => ProblemCategoryModel.fromMap(doc.data(), doc.id)).toList();
  }
}
