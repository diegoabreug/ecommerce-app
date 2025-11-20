import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.formKey});

  //para validar un formulario debemos crear un objeto de tipo globalkey<>
  final GlobalKey<FormState> formKey;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(

            validator: emailValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset('assets/icons/Message.svg',
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(30),
                      BlendMode.srcIn
                  ),
                ),
              ),
            ),
          ),


          SizedBox(height: defaultPadding),
          TextFormField(
            obscureText: true,
            validator: passwordValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset('assets/icons/Lock.svg',
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(30),
                      BlendMode.srcIn
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}