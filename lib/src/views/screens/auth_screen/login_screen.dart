import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/src/controllers/auth_controller.dart'; // Importar controlador
import 'package:ecommerce_app/src/views/components/login_form.dart';
import 'package:ecommerce_app/src/views/screens/auth_screen/register_screen.dart';
import 'package:flutter/material.dart';
import '../tabs_screen/tab_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController(); // Instancia del AuthController

  // Controladores de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Para mostrar carga

  loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Llamamos a Firebase para loguear
      String res = await _authController.loginUser(
          _emailController.text,
          _passwordController.text
      );

      setState(() {
        _isLoading = false;
      });

      if (res == 'Success') {
        // Mensaje de éxito opcional
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sesión iniciada correctamente'))
        );

        // Navegar a la pantalla principal
        // Usamos pushReplacement para que no puedan volver al login con "atrás"
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const TabScreen();
        }));
      } else {
        // Mostrar error si falla (ej: contraseña incorrecta)
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(res))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/login_dark.png', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Welcome Back', style: Theme.of(context).textTheme.headlineSmall,),
                  SizedBox(height: defaultPadding / 2),
                  const Text('Log in with your data'),
                  SizedBox(height: defaultPadding),

                  // Pasamos los controladores al formulario
                  LoginForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),

                  Align(
                    child: TextButton(onPressed: (){}, child: const Text('Forgot Password')),
                  ),
                  SizedBox(height: defaultPadding),

                  // Botón Login con indicador de carga
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                      onPressed: () {
                        loginUser();
                      },
                      child: const Text('Login')
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account"),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const RegisterScreen();
                          }));
                        },
                        child: const Text('Register Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}