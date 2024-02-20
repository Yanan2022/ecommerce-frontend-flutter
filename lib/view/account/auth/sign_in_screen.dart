import 'package:flutter/material.dart';
import 'package:frontend/component/input_outline_button.dart';
import 'package:frontend/component/input_text_button.dart';
import 'package:frontend/component/input_text_field.dart';
import 'package:frontend/controller/controllers.dart';
import 'package:frontend/extention/string_extention.dart';
import 'package:frontend/view/account/auth/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'Bienvenu, ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Sign in to continue!, ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2),
              ),
              const Spacer(
                flex: 3,
              ),
              InputTextField(
                title: 'Email',
                textEditingController: emailController,
                validation: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champ ne doit pas etre vide";
                  } else if (!value.isValidEmail) {
                    return "Si vous plait entrer un email valide";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              InputTextField(
                title: 'Password',
                obsecureText: true,
                textEditingController: passwordController,
                validation: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champ ne doit pas etre vide";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
              const Spacer(),
              InputTextButton(
                  title: 'Sign In',
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      authController.signIn(
                          email: emailController.text,
                          password: passwordController.text);
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              InputOutlineButton(
                  title: 'Back',
                  onClick: () {
                    Navigator.of(context).pop();
                  }),
              const Spacer(
                flex: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("I'm new user, "),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      )),
    );
  }
}
