import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/progress_controller.dart';

class ProgressPage extends StatelessWidget {
  final controller = Get.put(ProgressController());

  ProgressPage({super.key}) {
    controller.loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Progress',style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.arrow_back,color: Colors.white,)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        final list = controller.progressList;

        if (list.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.hourglass_empty, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No completed items yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start practicing to track your mental wellness journey!',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final p = list[index];
            final isPractice = p.itemType == 'practice';
            final icon = isPractice ? Icons.list_alt : Icons.self_improvement;
            final label = isPractice ? 'Practice' : 'Session';
            final dateStr = DateFormat('EEE, MMM d • hh:mm a').format(p.completedAt.toLocal());

            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isPractice ? Colors.blue.shade100 : Colors.purple.shade100,
                  child: Icon(icon, color: isPractice ? Colors.blue : Colors.purple),
                ),
                title: Text('$label Completed'),
                subtitle: Text('On: $dateStr'),
                trailing: Icon(Icons.check_circle, color: Colors.green),
              ),
            );
          },
        );
      }),
    );
  }
}
