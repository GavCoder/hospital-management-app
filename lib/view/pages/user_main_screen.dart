import 'package:flutter/material.dart';
import 'package:hospital_management_application/miscellaneous/authentication_services.dart';
import 'package:hospital_management_application/routes/routes.dart';
import 'package:hospital_management_application/widgets/app_button.dart';
import 'package:hospital_management_application/widgets/signOutWidget.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 252, 251),
      appBar: AppBar(
        actions: [
          SignOut(auth: _auth),
          const SizedBox(width: 5,)
        ],
        title: const Text('Hospital Management App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/Logo.png',
                  width: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Welcome [Name] [Surname]',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppButton(
                  buttonText: 'Appointments',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                  buttonText: 'My Profile',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                  buttonText: 'Review',
                  onTap: () {
                    Navigator.pushNamed(context, RouteManager.userReviewScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
