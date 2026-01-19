import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Si usas Firebase
import 'package:ecommerce_app/src/views/screens/auth_screen/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      title: 'Ecommerce App',
      //cambiar despues a LoginScreen
      home: LoginScreen(),
    );
  }
}