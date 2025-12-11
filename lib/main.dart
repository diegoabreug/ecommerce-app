import 'package:ecommerce_app/src/views/screens/auth_screen/login_screen.dart';
import 'package:ecommerce_app/src/views/screens/auth_screen/register_screen.dart';
import 'package:ecommerce_app/src/views/screens/tab_screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/themes/app_themes.dart';

// Cambiamos la función main a asíncrona (async)
void main() async {
  // 1. Asegura que la capa de interacción de widgets de Flutter esté vinculada.
  // Esto es necesario antes de ejecutar cualquier código de Flutter que no sea runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Opcional: Si tuvieras que inicializar algo como Firebase o bases de datos
  // await initializeOtherServices();

  runApp(IntecEcommerceApp());
}

class IntecEcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: AppThemes.lightTheme(context),
      home: TabScreen(),
      
        // theme: AppThemes.lightTheme(context),
      // initialRoute: LoginScreen.routeName,
      // routes: {
      //   LoginScreen.routeName: (context) => const LoginScreen(),
      //   RegisterScreen.routeName: (context) => const RegisterScreen(),
      // },
    );
  }
}