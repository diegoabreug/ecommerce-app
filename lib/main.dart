import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importar Auth
import 'package:ecommerce_app/src/views/screens/auth_screen/login_screen.dart';
import 'package:ecommerce_app/src/views/screens/tabs_screen/tab_screen.dart'; // Importar TabScreen
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
      debugShowCheckedModeBanner: false, // Quita la etiqueta 'Debug' de la esquina
      themeMode: ThemeMode.light,
      title: 'Ecommerce App',
      // En lugar de llamar directo a LoginScreen, preguntamos a Firebase
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Si snapshot tiene datos, significa que el usuario ya existe y está logueado
          if (snapshot.hasData) {
            return const TabScreen();
          }
          // Si no hay datos, el usuario no está logueado
          return const LoginScreen();
        },
      ),
    );
  }
}