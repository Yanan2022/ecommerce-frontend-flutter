import 'package:flutter/material.dart';
import 'package:frontend/component/input_outline_button.dart';
import 'package:frontend/component/input_text_button.dart';
import 'package:frontend/component/input_text_field.dart';
import 'package:frontend/controller/controllers.dart';
import 'package:frontend/extention/string_extention.dart';
import 'package:frontend/view/account/auth/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
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
                'Create Account, ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Sign up to started!, ',
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
                title: 'Full Name',
                textEditingController: fullNameController,
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
                title: 'Mot de passe',
                obsecureText: true,
                textEditingController: passwordController,
                validation: (String? value) {
                  List<String> _validation = [];
                  if (value == null || value.isEmpty) {
                    return "Ce champ ne doit pas etre vide";
                  } else {
                    if (!value.isValidPasswordHasNumber) {
                      _validation.add('doit contenir 1 chiffre');
                    }
                    if (!value.isValidPasswordHasCapitalLetter) {
                      _validation.add('doit contenir 1 lettre majuscule');
                    }
                    if (!value.isValidPasswordHasLowerCaseLetter) {
                      _validation.add('doit contenir 1 lettre simple');
                    }
                    if (!value.isValidPasswordHasSpecialCharacter) {
                      _validation
                          .add('doit contenir 1 caractère spécial[! @ # \$ %]');
                    }
                  }
                  // String? msg;
                  String msg = '';
                  if (_validation.isNotEmpty) {
                    for (var i = 0; i < _validation.length; i++) {
                      msg = msg + _validation[i];
                      if ((i + 1) != _validation.length) {
                        msg = msg + "\n ";
                      }
                    }
                  }
                  return msg.isNotEmpty ? msg : null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              InputTextField(
                title: 'Confirmez Mot de Passe',
                obsecureText: true,
                textEditingController: confirmController,
                validation: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champ ne doit pas etre vide";
                  } else if (passwordController.text != value) {
                    return "Confirmer le mot de passe ne correspond pas";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              InputTextButton(
                  title: 'Sign Up',
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      authController.signUp(
                          fullName: fullNameController.text,
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
                  const Text("I'm already a member, "),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    },
                    child: const Text(
                      "Sign In",
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
