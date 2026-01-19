import 'package:ecommerce_app/src/controllers/auth_controller.dart'; // Importar AuthController
import 'package:ecommerce_app/src/views/components/register_form.dart';
import 'package:ecommerce_app/src/views/screens/auth_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController(); // Instancia del AuthController

  // Controladores para capturar texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Para mostrar carga mientras registra

  registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Llamamos al metodo modificado del AuthController
      String res = await _authController.registerUser(
          _emailController.text,
          _passwordController.text,
          _nameController.text,
          "" // Teléfono vacío por ahora si no hay campo
      );

      setState(() {
        _isLoading = false;
      });

      if (res == 'Success') {
        // Éxito: Navegar al login o al Home
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cuenta creada con éxito')));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        // Error: Mostrar mensaje
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/signUp_dark.png', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Welcome', style: Theme.of(context).textTheme.headlineSmall,),
                  SizedBox(height: defaultPadding / 2),
                  Text('Create an account'),
                  SizedBox(height: defaultPadding + 13),

                  // Pasamos los controladores al Form
                  RegisterForm(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),

                  SizedBox(height: defaultPadding + 25),

                  // Botón de Registro actualizado
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                      onPressed: () {
                        registerUser();
                      },
                      child: Text('Register')
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Text('Login Now'),
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