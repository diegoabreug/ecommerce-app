import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,    // Nuevo
    required this.passwordController, // Nuevo
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;    // Nuevo
  final TextEditingController passwordController; // Nuevo

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController, // Asignamos controlador
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
            controller: passwordController, // Asignamos controlador
            obscureText: true,
            validator: passwordValidator.call,
            textInputAction: TextInputAction.done, // Cambiado a done
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