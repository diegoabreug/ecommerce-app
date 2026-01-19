import 'package:ecommerce_app/src/views/components/register_form.dart';
import 'package:ecommerce_app/src/views/screens/auth_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

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
                  Text('Welcome', style: Theme.of(context).textTheme.headlineSmall,),
                  SizedBox(
                    height: defaultPadding / 2,
                  ),
                  Text('Create an account'),

                  SizedBox(height: defaultPadding+13,),

                  //Widget de formulario de registro
                  RegisterForm(formkey: _formKey),

                  // SizedBox(height: defaultPadding+25,),
                  //
                  // //Boton de iniciar sesion
                  // ElevatedButton(
                  //     onPressed: (){
                  //       //Hay que validar el formulario y si esta correcto llamar al
                  //       //metodo para ejecutar el login
                  //       // if(_formKey.currentState!.validate()){
                  //       //
                  //       // }
                  //     },
                  //     child: Text('Register')
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: (){
                          //navegar a la pantalla de registro
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          },));
                        },
                        child:Text('Login Now',),
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