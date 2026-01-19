import 'package:ecommerce_app/constants.dart';
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
                  SizedBox(
                    height: defaultPadding / 2,
                  ),
                  Text('Log in with your data'),
                  SizedBox(height: defaultPadding,),

                  //crear un widget para el formulario
                  LoginForm(formKey: _formKey,),

                  //Boton de "Forgot Password"
                  Align(
                    child: TextButton(onPressed: (){}, child: Text('Forgot Password')),
                  ),
                  SizedBox(height: defaultPadding,), // ojo segun el profesor

                  //Boton de iniciar sesion
                  ElevatedButton(
                      onPressed: (){
                        //Hay que validar el formulario y si esta correcto llamar al
                        //metodo para ejecutar el login
                        if(_formKey.currentState!.validate()){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return TabScreen();
                          },));
                          }
                      },
                      child: Text('Login')
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account"),
                      TextButton(
                        onPressed: (){
                          //navegar a la pantalla de registro
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          },));
                        },
                        child:Text('Register Now',),
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