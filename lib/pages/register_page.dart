import 'package:bin_day_final_prototype/components/button.dart';
import 'package:bin_day_final_prototype/components/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text Editing Controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  // sign up function
  void signUp() async {
    if (passwordTextController.text != confirmPasswordTextController.text) {
      displayMessage("Passwords don't match");
      return;
    }

    try {
      // Create the user
      UserCredential userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      // Store their new details in a new document
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredentials.user!.email!)
          .set({
        'username' : emailTextController.text.split('@')[0],
        'constant bin' : 'green',
        'second' : 'red',
        'third' : 'blue',
        'bin day' : 'Tuesday',
      });
    } on FirebaseAuthException catch (e) {
      displayMessage(e.code);
      return;
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
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

                // Welcome Message
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 1.0,
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

                // Confirm Password
                const SizedBox(
                  height: 10.0,
                ),
                MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: 'Confirm Password',
                    obscureText: true),

                // Sign Up Button
                const SizedBox(
                  height: 10.0,
                ),
                MyButton(onTap: signUp, text: 'Sign Up'),

                // Go to Sign In Page
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(
                      width: 7.0,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Log In',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
