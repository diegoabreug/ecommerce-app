import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/src/views/components/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/login_dark.png', fit: BoxFit.cover),
          Padding(padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Welcome Back", style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(
                  height: defaultPadding / 2,
                ),
                Text('Log in with your data'),
                SizedBox(height: defaultPadding,),
                // crear widget para el formulario
                LoginForm(formKey: _formKey,),
                Align(
                  child: TextButton(onPressed: (){}, child: Text("Forgot Password?"),),
                ),
                SizedBox(height: defaultPadding,), //ojo aqui
                ElevatedButton(
                  onPressed: (){
                    // hay que validar el formulario y si esta correcto
                    // llamar al metodo para ejecutar el login
                    if(_formKey.currentState!.validate()){

                    }
                  },
                  child: Text("Login"),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have an account?"),
                      TextButton(onPressed: (){
                        // navegar  a la pantalla de registro
                        Navigator.pushNamed(context, '/register');
                      }, child: Text("Register Now",),
                      )
                    ]
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}