import 'package:flutter/material.dart';

//Styling the enabled border of the formTextField.
const enabledBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Color.fromARGB(255, 0, 77, 69),
    width: 1,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(20),
  ),
);

//Styling the focused border of the formTextField.
const focusedBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Color.fromARGB(255, 0, 77, 69),
    width: 2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(20),
  ),
);

//Styling the error border of the formTextField.
const errorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red,
    width: 1,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(20),
  ),
);

//Styling the focused error border of the formTextField.
const focusedErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red,
    width: 2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(20),
  ),
);

//This function has two parameters which is the label text and icon of the formTextField
InputDecoration formDecoration(String labelText, IconData? iconData) {
  return InputDecoration(
    errorMaxLines: 2,
    prefixIcon: Icon(
      iconData,
      color: const Color.fromARGB(255, 0, 77, 69),
    ),
    labelText: labelText,
    labelStyle: const TextStyle(
      color: Color.fromARGB(255, 0, 77, 69),
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    errorStyle: const TextStyle(
      fontSize: 10,
    ),
    enabledBorder: enabledBorder,
    focusedBorder: focusedBorder,
    errorBorder: errorBorder,
    focusedErrorBorder: focusedErrorBorder,
  );
}
