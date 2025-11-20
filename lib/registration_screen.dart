import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_up/ui_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _fromKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  Future<void> registerUser() async {
    if (!_fromKey.currentState!.validate()) return;
    try {
      setState(() => isLoading = true);
      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
            "name": nameController.text.trim(),
            "username": usernameController.text.trim(),
            "email": emailController.text.trim(),
            "createdAt": DateTime.now(),
          });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UiScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  // VALIDATION FUNCTION
  String? validateField(String? value, String field) {
    if (value == null || value.isEmpty) return "$field cannot be empty";
    if (field == "Email" &&
        !RegExp(r"^[\w-\.]+@([\w-]+[\w]{2,4}$)").hasMatch(value)) {
      return "Enter a valid Email";
    }
    if (field == "Password" && value.length < 6) {
      return "Please must be at least 6 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) => validateField(value, "Name"),
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: "Username"),
                validator: (value) => validateField(value, "Username"),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => validateField(value, "Email"),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) => validateField(value, "Password"),
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: registerUser,
                      child: Text("Register"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
