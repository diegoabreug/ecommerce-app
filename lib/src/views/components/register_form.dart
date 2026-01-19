
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/src/controllers/auth_controller.dart';

import '../screens/auth_screen/login_screen.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({super.key, required this.formkey});

  final GlobalKey<FormState> formkey;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  //consumimos el controlador
  final AuthController _authController = AuthController();

  late String email;
  late String password;
  late String confirmPassword;

  //variables para controlar el spinning
  bool isLoading = false;


  //metodo para el registro
  void registerUser() async {

    if(widget.formkey.currentState!.validate()){
      setState(() {
        isLoading = true;
      });
      String response = await _authController.registerUser(email, password);
      if(response == "Success"){
        Future.delayed(Duration.zero, () {
          //navegar a la pantalla de inicio
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return LoginScreen();
          },));
          //insertar un mensaje al usuario
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Created Successfully")));
        });
      }else{
        setState(() {
          isLoading = false;
        });
        Future.delayed(Duration.zero,(){
          //insertar un mensaje al usuario
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formkey,
        child: Column(
          children: [
            //Campo de correo electronico
            TextFormField(
              onChanged: (value){
                email = value;
              },
              validator: emailValidator.call,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.5),
                  child: SvgPicture.asset('assets/icons/Message.svg',
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(30), BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            SizedBox(height: defaultPadding+12,),

            // Campo de contrasena
            TextFormField(
              onChanged: (value){
                password = value;
              },
              obscureText: true,
              validator: passwordValidator.call,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.5),
                  child: SvgPicture.asset('assets/icons/Lock.svg',
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(30), BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            SizedBox(height: defaultPadding,),

            // Campo de confirmar contrasena
            TextFormField(
              onSaved: (value){
                confirmPassword =  value!;
              },
              obscureText: true,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please confirm your password';
                }
                if(password != value){
                  return 'Passwords do not match';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Confirm your password',
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.5),
                  child: SvgPicture.asset('assets/icons/Lock.svg',
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(30), BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            SizedBox(height: defaultPadding+25,),

            //Boton de iniciar sesion
            ElevatedButton(
                onPressed: (){
                  //Hay que validar el formulario y si esta correcto llamar al
                  //metodo para ejecutar el login

                  registerUser();
                  // if(_formKey.currentState!.validate()){
                  //
                  // }
                },
                child: isLoading ? CircularProgressIndicator(color: Colors.white,) : Text('Register')
            ),
          ],
        )
    );
  }
}
