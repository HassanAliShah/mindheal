import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindheal/utils/popups/loaders.dart';

import '../../best_practices_and_sessions/controller/practice_controller.dart';
import '../controller/problem_controller.dart';

class CategoryListPage extends StatelessWidget {
  final controller = Get.put(ProblemController());

   CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a Problem')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final cat = controller.categories[index];
            return ListTile(
              leading: cat.iconUrl.isNotEmpty
                  ? Image.network(cat.iconUrl, width: 40, height: 40)
                  : Icon(Icons.category),
              title: Text(cat.title),
              subtitle: Text(cat.description),
              onTap: () {
                // Navigate to session or best practice page
                PracticeController.instance.selectedProblemId.value = cat.title.toLowerCase();
                Get.back();
                TLoaders.successSnackBar(title: 'Loaded', message: '${cat.title} practices ready',);

              },
            );
          },
        );
      }),
    );
  }
}
