import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/repositories/progress_repository/progress_repository.dart';
import '../model/progress_model.dart';

class ProgressController extends GetxController {
  final _repo = ProgressRepository();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  RxList<ProgressModel> progressList = <ProgressModel>[].obs;

  Future<void> loadProgress() async {
    progressList.value = await _repo.getUserProgress(userId);
  }

  Future<void> markItemAsCompleted(String itemId, String type) async {
    final model = ProgressModel(
      id: '',
      userId: userId,
      itemId: itemId,
      itemType: type,
      completed: true,
      completedAt: DateTime.now(),
    );
    await _repo.markCompleted(model);
    await loadProgress();
  }

  Future<bool> isCompleted(String itemId) async {
    return await _repo.isItemCompleted(userId, itemId);
  }
}
