import 'package:flutter/material.dart';
import 'package:hospital_management_application/view/pages/authentication%20pages/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState () {
    Future.delayed(
      const Duration(seconds: 3),
      (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen()), (route) => false);
      }
    );
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 252, 251),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Logo.png',
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome to the Hospital Management Application',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
