import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../data/repositories/appointment_repository/appointment_repository.dart';
import '../models/doctor_model.dart';
import '../models/appointment_model.dart';

class AppointmentController extends GetxController {
  final _repo = AppointmentRepository();

  RxList<DoctorModel> doctors = <DoctorModel>[].obs;
  RxList<AppointmentModel> userAppointments = <AppointmentModel>[].obs;
  RxBool isLoading = false.obs;


  /// -- run one time to seed data to firebase
  @override
  onInit(){
    super.onInit();
    //seedAll();
  }

  Future<void> loadDoctors() async {
    isLoading.value = true;
    doctors.value = await _repo.getDoctors();
    isLoading.value = false;
  }

  Future<void> loadUserAppointments(String userId) async {
    isLoading.value = true;
    userAppointments.value = await _repo.getUserAppointments(userId);
    isLoading.value = false;
  }

  Future<void> bookAppointment(AppointmentModel appointment) async {
    try{
    await _repo.bookAppointment(appointment);
    await loadUserAppointments(appointment.userId);
    }catch(e)
    {
      print(e.toString());
    }
  }


  Future<void> seedProblemCategories() async {
    final categories = [
      {'id': 'stress', 'title': 'Stress', 'description': 'Help managing daily stress and overwhelm.', 'iconUrl': 'https://img.icons8.com/color/48/stress.png'},
      {'id': 'anxiety', 'title': 'Anxiety', 'description': 'Reduce anxiety and promote calm thinking.', 'iconUrl': 'https://img.icons8.com/color/48/anxiety.png'},
      {'id': 'productivity', 'title': 'Productivity', 'description': 'Improve focus and energy.', 'iconUrl': 'https://img.icons8.com/color/48/goal.png'},
      {'id': 'relationships', 'title': 'Relationships', 'description': 'Improve communication and connection.', 'iconUrl': 'https://img.icons8.com/color/48/love.png'},
      {'id': 'self-esteem', 'title': 'Self-Esteem', 'description': 'Build confidence and self-worth.', 'iconUrl': 'https://img.icons8.com/color/48/self-esteem.png'},
      {'id': 'depression', 'title': 'Depression', 'description': 'Support for low mood and sadness.', 'iconUrl': 'https://img.icons8.com/color/48/sad.png'},
    ];

    for (final cat in categories) {
      await FirebaseFirestore.instance.collection('problemCategories').doc(cat['id']).set({
        'title': cat['title'],
        'description': cat['description'],
        'iconUrl': cat['iconUrl'],
      });
    }

    print('✅ Problem Categories seeded');
  }

  Future<void> seedDoctors() async {
    final doctors = [
      {'name': 'Dr. Ayesha Khan', 'specialization': 'Psychiatrist', 'profileImage': 'https://i.pravatar.cc/150?img=11'},
      {'name': 'Dr. Ahmed Raza', 'specialization': 'Clinical Psychologist', 'profileImage': 'https://i.pravatar.cc/150?img=22'},
      {'name': 'Dr. Sana Tariq', 'specialization': 'Therapist', 'profileImage': 'https://i.pravatar.cc/150?img=33'},
      {'name': 'Dr. Bilal Sheikh', 'specialization': 'Counselor', 'profileImage': 'https://i.pravatar.cc/150?img=44'},
      {'name': 'Dr. Hina Malik', 'specialization': 'Mental Health Coach', 'profileImage': 'https://i.pravatar.cc/150?img=55'},
      {'name': 'Dr. Usman Ali', 'specialization': 'Cognitive Therapist', 'profileImage': 'https://i.pravatar.cc/150?img=66'},
    ];

    final now = DateTime.now();
    final List<DateTime> slotTemplate = List.generate(3, (i) => now.add(Duration(days: i + 1, hours: 10 + i)));

    for (final doc in doctors) {
      await FirebaseFirestore.instance.collection('doctors').add({
        'name': doc['name'],
        'specialization': doc['specialization'],
        'profileImage': doc['profileImage'],
        'availableSlots': slotTemplate.map((d) => Timestamp.fromDate(d)).toList(),
      });
    }

    print('✅ Doctors seeded');
  }

  Future<void> seedBestPractices() async {
    final practices = [
      {
        'problemId': 'stress',
        'title': 'Mindful Breathing',
        'description': 'Relieve stress using controlled breathing.',
        'steps': ['Inhale for 4 seconds', 'Hold for 4 seconds', 'Exhale slowly for 6 seconds']
      },
      {
        'problemId': 'anxiety',
        'title': 'Grounding Technique',
        'description': '5-4-3-2-1 grounding to manage anxiety.',
        'steps': ['Name 5 things you see', '4 things you can touch', '3 things you hear', '2 you can smell', '1 you can taste']
      },
      {
        'problemId': 'productivity',
        'title': 'Pomodoro Focus Method',
        'description': 'Work in short bursts to stay productive.',
        'steps': ['Work 25 mins', 'Break 5 mins', 'Repeat 4 times, then 15-min break']
      },
      {
        'problemId': 'relationships',
        'title': 'Active Listening',
        'description': 'Improve communication with loved ones.',
        'steps': ['Maintain eye contact', 'Don’t interrupt', 'Summarize what they said']
      },
      {
        'problemId': 'self-esteem',
        'title': 'Positive Affirmations',
        'description': 'Build self-confidence daily.',
        'steps': ['Say 3 positive things about yourself', 'Repeat them every morning']
      },
      {
        'problemId': 'depression',
        'title': 'Daily Routine Building',
        'description': 'Stabilize mood by structuring your day.',
        'steps': ['Wake up same time', 'Eat 3 meals', 'Take 20-min walk']
      }
    ];

    for (final p in practices) {
      await FirebaseFirestore.instance.collection('practices').add(p);
    }

    print('✅ Best Practices seeded');
  }

  Future<void> seedSessions() async {
    final sessions = [
      {
        'problemId': 'stress',
        'title': '10-min Guided Meditation',
        'type': 'meditation',
        'mediaUrl': 'https://example.com/stress-meditation.mp3',
      },
      {
        'problemId': 'anxiety',
        'title': 'Anxiety Journal Prompt',
        'type': 'journaling',
        'mediaUrl': '',
      },
      {
        'problemId': 'productivity',
        'title': 'Morning Focus Session',
        'type': 'audio',
        'mediaUrl': 'https://example.com/productivity-focus.mp3',
      },
      {
        'problemId': 'relationships',
        'title': 'Couples Mindfulness Practice',
        'type': 'exercise',
        'mediaUrl': '',
      },
      {
        'problemId': 'self-esteem',
        'title': 'Confidence Visualization',
        'type': 'meditation',
        'mediaUrl': 'https://example.com/selfesteem-visual.mp3',
      },
      {
        'problemId': 'depression',
        'title': 'Soothing Sounds Playlist',
        'type': 'audio',
        'mediaUrl': 'https://example.com/depression-sounds.mp3',
      },
    ];

    for (final s in sessions) {
      await FirebaseFirestore.instance.collection('sessions').add(s);
    }

    print('✅ Sessions seeded');
  }

  Future<void> seedAll() async {
    await seedProblemCategories();
    await seedDoctors();
    await seedBestPractices();
    await seedSessions();
    print("✅ All seed data written to Firestore.");
  }
}
