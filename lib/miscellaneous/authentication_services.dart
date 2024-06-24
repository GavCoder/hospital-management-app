import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_application/routes/routes.dart';



class AuthService{

  Future <void> signOut (BuildContext context) async{
    try{
      await FirebaseAuth.instance.signOut();

      Navigator.pushReplacementNamed(context, RouteManager.signInScreen);
    }
    catch(e){
      throw FormatException('Could not logout: ${e.toString()}');
    }
  }

  // final _auth = FirebaseAuth.instance;
  // Future <User?> createUserWithEmailAndPassword(String email, String password) async{
  //   try{
  //     final credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //   return credentials.user;
  //   }
  //   catch(e){

  //   } 
  // }
}