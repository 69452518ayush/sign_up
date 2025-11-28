import 'package:flutter/material.dart';
import 'package:sign_up/auth_service.dart';


class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthService auth = AuthService();

  signup() async {
    if (_formKey.currentState!.validate()) {
      String? msg = await auth.signUp(email.text, password.text);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(msg ?? "Account created")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => auth.validateEmail(v!),
              ),
              SizedBox(height: 15),

              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => auth.validatePassword(v!),
              ),

              SizedBox(height: 20),

              ElevatedButton(onPressed: signup, child: Text("Create Account")),
            ],
          ),
        ),
      ),
    );
  }
}
