import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_management_application/miscellaneous/validators.dart';
import 'package:hospital_management_application/models/app_model.dart';
import 'package:hospital_management_application/widgets/calender_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:hospital_management_application/routes/routes.dart';
import 'package:hospital_management_application/widgets/app_form_field.dart';
import 'package:hospital_management_application/widgets/app_button.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _dobController;
  late TextEditingController _idNumController;
  late TextEditingController _phoneNumController;

  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _dobController = TextEditingController();
    _idNumController = TextEditingController();
    _phoneNumController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _dobController.dispose();
    _idNumController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_signUpFormKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
      });
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Add user details to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _nameController.text.trim(),
          'surname': _surnameController.text.trim(),
          'dateOfBirth': _dobController.text.trim(),
          'phoneNumber': _phoneNumController.text.trim(),
          'identityNumber': _idNumController.text.trim(),
          'email': _emailController.text.trim(),
        });

        context.read<AppModel>().setEmail(_emailController.text);

        var snackBar = SnackBar(
          content: Consumer<AppModel>(
            builder: (context, value, child) {
              return Text(
                '${value.getEmail} has signed up successfully',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              );
            },
          ),
          backgroundColor: Colors.green,
          padding: const EdgeInsets.all(10.0),
          elevation: 10,
          duration: const Duration(seconds: 3),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.of(context).pushNamed(RouteManager.signInScreen);
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to sign up: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Management App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/Logo.png',
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  AppFormField(
                    controller: _nameController,
                    labelText: 'Name',
                    iconData: Icons.person,
                    validation: validateName,
                  ),
                  const SizedBox(height: 15),
                  AppFormField(
                    controller: _surnameController,
                    labelText: 'Surname',
                    iconData: Icons.person,
                    validation: validateSurname,
                  ),
                  const SizedBox(height: 15),
                  CalendarDatePickerField(
                    controller: _dobController,
                    labelText: 'Date Of Birth',
                  ),
                  const SizedBox(height: 15),
                  AppFormField(
                    controller: _idNumController,
                    labelText: 'ID Number',
                    iconData: Icons.credit_card,
                    formFieldMaxLength: 13,
                    validation: validateIDNumber,
                  ),
                  const SizedBox(height: 15),
                  AppFormField(
                    controller: _phoneNumController,
                    labelText: 'Phone Number',
                    iconData: Icons.phone,
                    formFieldMaxLength: 10,
                    validation: validatePhoneNumber,
                  ),
                  const SizedBox(height: 15),
                  AppFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    iconData: Icons.mail,
                    validation: validateEmail,
                  ),
                  const SizedBox(height: 15),
                  AppFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    iconData: Icons.lock,
                    validation: validatePassword,
                    obscureText: true,
                    formFieldMaxLength: 8,
                  ),
                  const SizedBox(height: 15),
                  AppFormField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    iconData: Icons.lock,
                    validation: (value) => validateConfirmPassword(
                        _passwordController.text, value),
                    obscureText: true,
                    formFieldMaxLength: 8,
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    buttonText: 'Sign Up',
                    onTap: _signUp,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RouteManager.signInScreen),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 53, 226),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 30,
                  ),
                  // This is the text that will appear below the Login button.
                  const Text(
                    "By signing in I agree to the T's & C's",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 0, 77, 69),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
