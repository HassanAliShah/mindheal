import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/repositories/feedback_repository/feedback_repository.dart';
import '../model/feedback_model.dart';

class FeedbackController extends GetxController {
  final _repo = FeedbackRepository();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  RxList<FeedbackModel> feedbackList = <FeedbackModel>[].obs;

  Future<void> submit(String itemType, String message, {String? itemId, int? rating}) async {
    final model = FeedbackModel(
      id: '',
      userId: userId,
      itemType: itemType,
      message: message,
      itemId: itemId,
      rating: rating,
      createdAt: DateTime.now(),
    );
    await _repo.submitFeedback(model);
    await loadUserFeedback();
  }

  Future<void> loadUserFeedback() async {
    feedbackList.value = await _repo.getUserFeedback(userId);
  }
}
