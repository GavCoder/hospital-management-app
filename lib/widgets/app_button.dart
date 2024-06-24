import 'package:flutter/material.dart';

//An AppButton class extending a StatelessWidget

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.buttonText,
      required this.onTap});

  final String buttonText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 77, 69),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size.fromHeight(50)),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
