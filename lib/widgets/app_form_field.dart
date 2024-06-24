import 'package:flutter/material.dart';
import '../miscellaneous/constants.dart';

//A LoginFormField class extending a StatelessWidget

class AppFormField extends StatelessWidget {
   const AppFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.iconData,
    required this.validation,
    this.formFieldMaxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.textInputType,
  }); //This is a class extracted from the login class. It receives four parameter, all of which will be passed from the class that uses it.

  final TextEditingController controller;
  final String labelText;
  final IconData? iconData;
  final String? Function(String? data) validation;
  final bool obscureText;
  final int? formFieldMaxLength;
  final int? maxLines;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validation,
      keyboardType: textInputType,
      obscureText: obscureText,
      maxLines: maxLines,
      maxLength: formFieldMaxLength,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: formDecoration(labelText, iconData), //Here, I am calling the formDecoration function, which will style the login form based on the specified properties. This funtion receives two arguments: the label text and an icon.
    );
  }
}
