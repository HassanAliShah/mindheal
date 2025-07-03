import 'package:get/get.dart';

import '../../../data/repositories/practice_repository/practice_repository.dart';
import '../module/practice_model.dart';
import '../module/session_model.dart';


class PracticeController extends GetxController {
  static PracticeController get instance => Get.find();

  final _repo = PracticeRepository();

  RxList<PracticeModel> practices = <PracticeModel>[].obs;
  RxList<SessionModel> sessions = <SessionModel>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedProblemId = 'stress'.obs;

  void loadContentForProblem(String problemId) async {
    try {
      isLoading.value = true;
      practices.value = await _repo.getPracticesByProblem(problemId);
      sessions.value = await _repo.getSessionsByProblem(problemId);
    } catch (e) {
      Get.snackbar("Error", "Failed to load practices or sessions");
    } finally {
      isLoading.value = false;
    }
  }
}
