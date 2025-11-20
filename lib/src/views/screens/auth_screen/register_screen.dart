import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/src/views/components/register_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _executeRegistration() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful. Creating account...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar( // Optional: Added back for structure, remove if not needed
      //   automaticallyImplyLeading: true,
      //   elevation: 0,
      // ),
      // The body property correctly defined inside Scaffold:
      body: Column(
        children: [
          Image.asset(
            'assets/images/signUp_dark.png',
            fit: BoxFit.cover,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Create Your Account!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: defaultPadding / 2),
                    Text('Register with your information.'),
                    SizedBox(height: defaultPadding),

                    RegisterForm(formKey: _formKey),

                    SizedBox(height: defaultPadding),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _executeRegistration();
                        }
                      },
                      child: const Text("Register"),
                    ),

                    SizedBox(height: defaultPadding),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Sign In"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}