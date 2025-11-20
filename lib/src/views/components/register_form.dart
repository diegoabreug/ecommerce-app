import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Field 1: Full Name
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                // Translated validation error message
                return 'Please enter your full name.';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              // Translated hint text
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
            validator: emailValidator.call,
            textInputAction: TextInputAction.next,
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
            obscureText: true,
            validator: passwordValidator.call,
            textInputAction: TextInputAction.done,
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