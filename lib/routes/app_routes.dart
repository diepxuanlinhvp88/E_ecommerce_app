import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/welcome_onboarding_screen/welcome_onboarding_screen.dart';
import '../presentation/sign_in_screen/sign_in_screen.dart';
import '../presentation/sign_up_screen/sign_up_screen.dart';


import 'package:flutter/cupertino.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';

  static const String splashScreen = '/splash_screen';

  static const String welcomeOnboardingScreen = '/welcome_onboarding_screen';

  static const String signInScreen = '/sign_in_screen';

  static const String homeScreen = '/home_screen';

  static const String signUpScreen = '/sign_up_screen';

  static Map<String, WidgetBuilder> routes = {
    initialRoute: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    signInScreen: (context) => const SignInScreen(),
    // homeScreen: (context) => const HomeScreen(),
    signUpScreen: (context) => const SignUpScreen(),
    welcomeOnboardingScreen: (context) => const WelcomeOnboardingScreen(),
  };
}
