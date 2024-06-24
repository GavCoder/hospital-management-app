import 'package:flutter/material.dart';

//AppModel class extends ChangeNotifier to enable state changes
class AppModel with ChangeNotifier {
  String _email = '';
  String _name = '';
  String _surname = '';
  
  //Functions to notify listeners to trigger a rebuild
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  String get getEmail => _email;

  //Functions to notify listeners to trigger a rebuild
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  String get getName => _name;

  //Functions to notify listeners to trigger a rebuild
  void setSurname(String surname) {
    _surname = surname;
    notifyListeners();
  }

  String get getSurname => _surname;
}
