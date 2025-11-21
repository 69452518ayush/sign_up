import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../forgot.dart';
import '../signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Enter email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Enter password'),
            ),
            ElevatedButton(onPressed: (() => signIn()), child: Text("Login")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (() => Get.to(Signup())),
              child: Text("Register now"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (() => Get.to(Forgot())),
              child: Text("Forgot password?"),
            ),
          ],
        ),
      ),
    );
  }
}
