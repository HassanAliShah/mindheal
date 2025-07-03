import 'package:get/get.dart';

import '../../../data/repositories/problem_repository/problem_repository.dart';
import '../model/ProblemCategoryModel.dart';

class ProblemController extends GetxController {
  final ProblemRepository _repo = ProblemRepository();
  RxList<ProblemCategoryModel> categories = <ProblemCategoryModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading.value = true;
      categories.value = await _repo.fetchCategories();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    } finally {
      isLoading.value = false;
    }
  }
}
