import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_management_application/miscellaneous/validators.dart';
import 'package:hospital_management_application/models/app_model.dart';
import 'package:provider/provider.dart';
import 'package:hospital_management_application/routes/routes.dart';
import 'package:hospital_management_application/widgets/app_form_field.dart';
import 'package:hospital_management_application/widgets/app_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<
      FormState>(); // Global Key that uniquely identifies the form widget.

  // Controllers for handling user input in the form text fields.
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_signInFormKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
      });
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (userCredential.user != null) {
          // Using provider to pass the email which was entered by the user to the setEmail function.
          context.read<AppModel>().setEmail(_emailController.text);

          // Retrieving the email from the email controller and a message, into a variable
          var snackBar = SnackBar(
            content: Consumer<AppModel>(
              builder: (context, value, child) {
                return Text(
                  '${value.getEmail} has logged in successfully',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                );
              },
            ),
            backgroundColor: Colors.green,
            padding: const EdgeInsets.all(10.0),
            elevation: 10,
            duration: const Duration(seconds: 3),
          );

          // Displaying a snackbar containing the user's email and a message.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // This method is used for navigating to a named route within the app.
          Navigator.of(context).pushNamed(RouteManager.userMainScreen);
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to sign in: ${e.toString()}';
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
            key: _signInFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Inserting an image that will serve as the application logo.
                  Image.asset(
                    'images/Logo.png',
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  // The first text field: Email text field. It receives four arguments
                  AppFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    iconData: Icons.mail,
                    validation: validateEmail,
                  ),
                  const SizedBox(height: 10),
                  // The second text field: Password text field. It receives four arguments
                  AppFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    iconData: Icons.lock,
                    validation: validatePassword,
                    obscureText: true,
                    formFieldMaxLength: 8,
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    buttonText: 'Sign In',
                    onTap: _signIn,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RouteManager.signUpScreen),
                        child: const Text(
                          'Sign Up',
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
