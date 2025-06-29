
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mindheal/features/authentication/screens/login/login.dart';
import 'package:mindheal/features/authentication/screens/onboarding/onboarding.dart';
import 'package:mindheal/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:mindheal/features/authentication/screens/signup/signup.dart';
import 'package:mindheal/features/authentication/screens/signup/verify_email.dart';
import '../features/personalization/screens/profile/profile.dart';
import 'routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen(),),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.logIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}
