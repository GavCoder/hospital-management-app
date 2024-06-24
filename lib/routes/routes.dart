import 'package:flutter/material.dart';
import 'package:hospital_management_application/view/pages/admin_home_screen.dart';
import 'package:hospital_management_application/view/pages/appointment_screen.dart';
import 'package:hospital_management_application/view/pages/authentication%20pages/sign_in_screen.dart';
import 'package:hospital_management_application/view/pages/authentication%20pages/sign_up_screen.dart';
import 'package:hospital_management_application/view/pages/splash_screen.dart';
import 'package:hospital_management_application/view/pages/user_main_screen.dart';
import 'package:hospital_management_application/view/pages/user_review_screen.dart';

//Initial routes
class RouteManager {
  static const String signInScreen = '/';
  static const String signUpScreen = '/signUpScreen';
  static const String userMainScreen = '/userMainScreen';
  static const String splashScreen = '/splashScreen';
  static const String appointmentScreen = '/appointmentScreen';
  static const String userReviewScreen = '/userReviewScreen';
  static const String userProfile = '/userProfileScreen';
  static const String sysadminRegister = '/sysadminRegisterScreen';
  static const String adminHomeScreen = '/adminHomeScreen';

  //Function used to generate routes dynamically
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case signInScreen:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
      
      case signUpScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );

      case userMainScreen:
        return MaterialPageRoute(
          builder: (context) => const UserMainScreen(),
        );

      case appointmentScreen:
        return MaterialPageRoute(
          builder: (context) => const UserAppointmentScreen(),
        );

      case userReviewScreen:
        return MaterialPageRoute(
          builder: (context) => const UserReviewScreen(),
        );

      // case userProfile:
      //   return MaterialPageRoute(
      //     builder: (context) => const UserProfile(),
      //   );

      // case sysadminRegister:
      //   return MaterialPageRoute(
      //     builder: (context) => const SysAdminRegister(),
      //   );

       case adminHomeScreen:
         return MaterialPageRoute(
         builder: (context) => const AdminHomeScreen(),
        );

      default:
        throw const FormatException("Page does not exist.");
    }
  }
}
