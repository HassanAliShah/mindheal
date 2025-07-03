import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:mindheal/data/repositories/authentication/authentication_repository.dart';

import '../best_practices_and_sessions/controller/practice_controller.dart';
import '../best_practices_and_sessions/screens/best_practice_page.dart';

class HomePage extends StatelessWidget {


  final List<_HomeOption> options = [
    _HomeOption('🧠 Mental Challenges', 'Explore & manage issues like stress, anxiety', Icons.category, '/categories'),
    _HomeOption('✅ Best Practices', 'Follow personalized wellness steps', Icons.list_alt, '/practices'),
    _HomeOption('🩺 Appointments', 'Book sessions with certified doctors', Icons.calendar_today, '/appointments'),
    _HomeOption('📈 Progress', 'Track your healing journey', Icons.bar_chart, '/progress'),
    _HomeOption('💬 Feedback', 'Share your thoughts with us', Icons.feedback, '/feedback'),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(PracticeController());
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("MindHeal Hub",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple.shade300,
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildWelcomeBanner(),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return Animate(
                    effects: [FadeEffect(), SlideEffect()],
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Icon(option.icon, size: 36, color: Colors.deepPurple),
                        title: Text(option.title, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(option.subtitle),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          if(option.route == "/practices")
                          {
                          Get.to(BestPracticePage(problemId: PracticeController.instance.selectedProblemId.value));
                          }else{
                          Get.toNamed(option.route);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [Colors.deepPurple.shade300, Colors.purple.shade100]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome to MindHeal Hub 👋',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Let’s work on your wellness journey together.',
              style: TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    ).animate().fade().slideY(duration: 500.ms);
  }
}

class _HomeOption {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  _HomeOption(this.title, this.subtitle, this.icon, this.route);
}
