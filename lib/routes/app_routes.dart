
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mindheal/features/authentication/screens/login/login.dart';
import 'package:mindheal/features/authentication/screens/onboarding/onboarding.dart';
import 'package:mindheal/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:mindheal/features/authentication/screens/signup/signup.dart';
import 'package:mindheal/features/authentication/screens/signup/verify_email.dart';
import '../features/Appointment/screens/DoctorListPage.dart';
import '../features/Feedback/screen/feedback_page.dart';
import '../features/Home/home_page.dart';
import '../features/Progress_tracking/screen/progress_page.dart';
import '../features/best_practices_and_sessions/screens/best_practice_page.dart';
import '../features/personalization/screens/profile/profile.dart';
import '../features/problemCategory/screens/categpry_list_page.dart';
import 'routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen(),),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.logIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
    GetPage(name: TRoutes.home, page: () => HomePage()),
    GetPage(name: TRoutes.categories, page: () => CategoryListPage()),
    GetPage(name: TRoutes.practices, page: () => BestPracticePage(problemId: 'stress')), // or dynamic
    GetPage(name: TRoutes.appointments, page: () => DoctorListPage()),
    GetPage(name: TRoutes.progress, page: () => ProgressPage()),
    GetPage(name: TRoutes.feedback, page: () => FeedbackPage(itemType: 'general')),
  ];
}
