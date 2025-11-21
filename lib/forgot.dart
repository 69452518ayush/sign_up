import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_up/signup.dart';
import 'package:sign_up/wrapper.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailController.text,

    );
    //Get.offAll(Wrapper());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Enter email'
              ),
            ),
            /*TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Enter password'
              ),
            ),*/
            ElevatedButton(onPressed: (()=>reset()), child: Text("Send link")),

          ],
        ),
      ),
    );
  }
}
