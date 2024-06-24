import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_application/models/app_model.dart';
import 'package:hospital_management_application/routes/routes.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBLCC6KbL7Q_EZ4-gZ7o8jDjNXNgQoqhXI",
            authDomain: "hospital-management-app-5b4c5.firebaseapp.com",
            projectId: "hospital-management-app-5b4c5",
            storageBucket: "hospital-management-app-5b4c5.appspot.com",
            messagingSenderId: "330347116478",
            appId: "1:330347116478:web:aa4f5236229f61a88a6bef"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Here I applied ChangeNotifierProvider so that I can be able to use Consumer and other Provider features.
    return ChangeNotifierProvider(
      create: (context) => AppModel(),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.teal,
              elevation: 5,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RouteManager
              .splashScreen, //This leads to the initial screen of the app
          onGenerateRoute: RouteManager
              .generateRoute, //This will generate routes (screens/pages) based on the static generateRoute function called through the class it belongs to
        );
      },
    );
  }
}
