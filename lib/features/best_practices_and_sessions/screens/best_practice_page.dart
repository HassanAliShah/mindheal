import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Progress_tracking/controller/progress_controller.dart';
import '../controller/practice_controller.dart';

class BestPracticePage extends StatelessWidget {
  final String problemId;
  final controller = PracticeController.instance;
  final progressController = Get.put(ProgressController());

  BestPracticePage({super.key, required this.problemId}) {
    controller.loadContentForProblem(problemId);
    progressController.loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Best Practices & Sessions',style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🧠 Best Practices', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 12),

              ...controller.practices.map((practice) => Obx(() {
                final isCompleted = progressController.progressList.any(
                      (p) => p.itemId == practice.id && p.itemType == 'practice',
                );

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    childrenPadding: const EdgeInsets.only(bottom: 10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(practice.title, style: theme.textTheme.titleMedium)),
                        IconButton(
                          icon: Icon(Icons.check_circle,
                              color: isCompleted ? Colors.green : Colors.grey),
                          onPressed: isCompleted
                              ? null
                              : () async {
                            await progressController
                                .markItemAsCompleted(practice.id, 'practice');
                            Get.snackbar(
                              '🎉 Well Done!',
                              '"${practice.title}" marked as completed',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green.shade100,
                              colorText: Colors.black87,
                              duration: const Duration(seconds: 2),
                            );
                          },
                        ),
                      ],
                    ),
                    subtitle: Text(practice.description, style: TextStyle(color: Colors.grey.shade700)),
                    children: practice.steps
                        .map((step) => ListTile(
                      dense: true,
                      leading: Icon(Icons.circle, size: 8, color: Colors.deepPurple),
                      title: Text(step),
                    ))
                        .toList(),
                  ),
                );
              })),

              const SizedBox(height: 30),

              Text('🎧 Recommended Sessions', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 12),

              ...controller.sessions.map((session) => Obx(() {
                final isCompleted = progressController.progressList.any(
                      (p) => p.itemId == session.id && p.itemType == 'session',
                );

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade100,
                      child: Icon(Icons.self_improvement, color: Colors.deepPurple),
                    ),
                    title: Text(session.title, style: theme.textTheme.titleMedium),
                    subtitle: Text("Type: ${toTitleCase(session.type)}"),
                    trailing: IconButton(
                      icon: Icon(Icons.check_circle,
                          color: isCompleted ? Colors.green : Colors.grey),
                      onPressed: isCompleted
                          ? null
                          : () async {
                        await progressController
                            .markItemAsCompleted(session.id, 'session');
                        Get.snackbar(
                          '🎉 Good Job!',
                          '"${session.title}" completed',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green.shade100,
                          colorText: Colors.black87,
                          duration: const Duration(seconds: 2),
                        );
                      },
                    ),
                    onTap: () {
                      // TODO: Play media or navigate to details
                      Get.snackbar(
                        "🚧 Coming Soon",
                        "Session playback not yet available.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange.shade100,
                      );
                    },
                  ),
                );
              })),
            ],
          ),
        );
      }),
    );
  }

  String toTitleCase(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }
}
