import 'package:flutter/material.dart';

//An AppTextField class extending a StatelessWidget

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validation,
  }); //This class is called when the user wants to add a text field to his application, that whose purpose is specific. This class receives two arguments: the controller name and label text.

  final TextEditingController controller;
  final String labelText;
  final String? Function(String? data) validation;

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: null,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 77, 69),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 77, 69),
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 77, 69),
            width: 2,
          ),
        ),
      ),
    );
  }
}