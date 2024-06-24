import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_application/miscellaneous/authentication_services.dart';
import 'package:hospital_management_application/miscellaneous/validators.dart';
import 'package:hospital_management_application/routes/routes.dart';
import 'package:hospital_management_application/widgets/app_button.dart';
import 'package:hospital_management_application/widgets/app_form_field.dart';
import 'package:hospital_management_application/widgets/signOutWidget.dart';

class UserReviewScreen extends StatefulWidget {
  const UserReviewScreen({super.key});

  @override
  State<UserReviewScreen> createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  final _reviewFormKey = GlobalKey<FormState>();

  late TextEditingController _hospitalNameController;
  late TextEditingController _userReviewController;
  String _errorMessage = '';
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _hospitalNameController = TextEditingController();
    _userReviewController = TextEditingController();
  }

  @override
  void dispose() {
    _hospitalNameController.dispose();
    _userReviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_reviewFormKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
      });
      try {
        // Get current user's ID
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Save review to Firestore
          await FirebaseFirestore.instance.collection('reviews').add({
            'userId': user.uid,
            'hospitalName': _hospitalNameController.text.trim(),
            'review': _userReviewController.text.trim(),
            'date': DateTime.now().toString(),
          });

          // Show success message
          var snackBar = const SnackBar(
            content: Text(
              'Review submitted successfully',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.green,
            padding: EdgeInsets.all(10.0),
            elevation: 10,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // Clear form fields
          _hospitalNameController.clear();
          _userReviewController.clear();

          Navigator.pushNamed(context, RouteManager.userMainScreen);
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to submit review: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 252, 251),
      appBar: AppBar(
        actions: [
          SignOut(auth: _auth),
          const SizedBox(
            width: 5,
          )
        ],
        title: const Text('Review'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _reviewFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/review_icon.png',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Your feedback is invaluable to us. By sharing your experience, you help us continually improve our services and provide better care for our patients. Thank you for taking the time to leave a review.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppFormField(
                    controller: _hospitalNameController,
                    labelText: 'Hospital',
                    validation: validateHospitalName,
                  ),
                  const SizedBox(height: 15),
                  AppFormField(
                    controller: _userReviewController,
                    labelText: 'Review',
                    validation: validateReview,
                    maxLines: null,
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    buttonText: 'Submit Review',
                    onTap: _submitReview,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
