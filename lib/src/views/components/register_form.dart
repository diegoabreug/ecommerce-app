import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,    // Nuevo
    required this.emailController,   // Nuevo
    required this.passwordController,// Nuevo
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;     // Nuevo
  final TextEditingController emailController;    // Nuevo
  final TextEditingController passwordController; // Nuevo

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Field 1: Full Name
          TextFormField(
            controller: nameController, // Asignar controlador
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name.';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Full Name",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  'assets/icons/Profile.svg',
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(30),
                      BlendMode.srcIn),
                ),
              ),
            ),
          ),
          SizedBox(height: defaultPadding),
          // Field 2: Email
          TextFormField(
            controller: emailController, // Asignar controlador
            validator: emailValidator.call, // Asegúrate de que emailValidator exista en constants.dart
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  'assets/icons/Message.svg',
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(30),
                      BlendMode.srcIn),
                ),
              ),
            ),
          ),
          SizedBox(height: defaultPadding),
          // Field 3: Password
          TextFormField(
            controller: passwordController, // Asignar controlador
            obscureText: true,
            validator: passwordValidator.call, // Asegúrate de que passwordValidator exista
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  'assets/icons/Lock.svg',
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(30),
                      BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}