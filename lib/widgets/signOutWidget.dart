import 'package:flutter/material.dart';
import 'package:hospital_management_application/miscellaneous/authentication_services.dart';

class SignOut extends StatelessWidget {
  const SignOut({
    super.key,
    required AuthService auth,
  }) : _auth = auth;

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _auth.signOut(context);
      },
      child: const Text(
        'LOGOUT',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}