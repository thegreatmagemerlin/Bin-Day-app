import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bin_day_final_prototype/components/button.dart';
import 'package:bin_day_final_prototype/components/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text Editing Controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // Sign In Function
  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text, password: passwordTextController.text,);
    } on FirebaseAuthException catch (e) {
      displayMessage(e.code);
    }
  }


  // Display Message
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 150.0,
                  ),

                  // Logo
                  Icon(
                    Icons.restore_from_trash,
                    size: 120,
                    color: Colors.grey[800],
                  ),

                  // Welcome Back
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 3.0,
                        color: Colors.grey[600]),
                  ),

                  // Username
                  const SizedBox(
                    height: 20.0,
                  ),
                  MyTextField(
                      controller: emailTextController,
                      hintText: 'Email',
                      obscureText: false),

                  // Password
                  const SizedBox(
                    height: 10.0,
                  ),
                  MyTextField(
                      controller: passwordTextController,
                      hintText: 'Password',
                      obscureText: true),

                  // Sign in button
                  const SizedBox(
                    height: 10.0,
                  ),
                  MyButton(onTap: signIn, text: 'Log In'),

                  // go to register page button
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        width: 7.0,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
