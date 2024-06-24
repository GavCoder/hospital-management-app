import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_management_application/miscellaneous/authentication_services.dart';
import 'package:hospital_management_application/miscellaneous/validators.dart';
import 'package:hospital_management_application/routes/routes.dart';
import 'package:hospital_management_application/widgets/app_button.dart';
import 'package:hospital_management_application/widgets/app_form_field.dart';
import 'package:hospital_management_application/widgets/calender_date_picker.dart';
import 'package:hospital_management_application/widgets/signOutWidget.dart';


class UserAppointmentScreen extends StatefulWidget {
  const UserAppointmentScreen({super.key});

  @override
  State<UserAppointmentScreen> createState() => _UserAppointmentScreenState();
}

class _UserAppointmentScreenState extends State<UserAppointmentScreen> {
  final _appointmentFormKey = GlobalKey<FormState>();

  late TextEditingController _appointmentController;
  late TextEditingController _reasonController;

  String _errorMessage = '';
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _appointmentController = TextEditingController();
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _appointmentController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitAppointment() async {
    if (_appointmentFormKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
      });
      try {
        // Get current user's ID
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Save review to Firestore
          await FirebaseFirestore.instance.collection('appointments').add({
            'userId': user.uid,
            'appointment': _appointmentController.text.trim(),
            'reasonForAppointment': _reasonController.text.trim(),
            'dateReceived': DateTime.now().toString(),
          });

          // Show success message
          var snackBar = const SnackBar(
            content: Text(
              'Your appointment is received',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.green,
            padding: EdgeInsets.all(10.0),
            elevation: 10,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // Clear form fields
          _appointmentController.clear();
          _reasonController.clear();

          Navigator.pushNamed(context, RouteManager.userMainScreen);
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to submit appointment: ${e.toString()}';
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
          const SizedBox(width: 5,)
        ],
        title: const Text('Appointment'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _appointmentFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/appointment.png',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CalendarDatePickerField(
                    controller: _appointmentController,
                    labelText: 'Appointment Date',
                  ),
                  const SizedBox(height: 15),
                  AppFormField(
                    controller: _reasonController,
                    labelText: 'Reason For Appointment',
                    validation: validateReview,
                    maxLines: null,
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    buttonText: 'Submit Appointment',
                    onTap: _submitAppointment,
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
