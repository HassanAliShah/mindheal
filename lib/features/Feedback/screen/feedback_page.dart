import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindheal/utils/popups/loaders.dart';

import '../controller/feedback_controller.dart';

class FeedbackPage extends StatelessWidget {
  final controller = Get.put(FeedbackController());

  final TextEditingController messageC = TextEditingController();
  final RxInt rating = 0.obs;
  final String itemType;
  final String? itemId;

  FeedbackPage({super.key, required this.itemType, this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: messageC,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Your feedback',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Rate your experience:'),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating.value ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => rating.value = index + 1,
                );
              }),
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (messageC.text.trim().isEmpty) return;
                await controller.submit(
                  itemType,
                  messageC.text.trim(),
                  itemId: itemId,
                  rating: rating.value,
                );
                TLoaders.successSnackBar(title: "Thank you!",message: "Your feedback was submitted.");
                messageC.clear();
                rating.value = 0;
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded edges
                ),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14), // Custom padding
                backgroundColor: Colors.deepPurple, // Optional: custom color
                foregroundColor: Colors.white, // Text color
                elevation: 4,
              ),
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )

          ],
        ),
      ),
    );
  }
}
