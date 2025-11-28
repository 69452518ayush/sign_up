import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_up/auth_service.dart';
import 'package:sign_up/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AuthService auth = AuthService();
  bool loading = false;

  loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => loading = true);

      String? result = await auth.login(email.text, password.text);

      setState(() => loading = false);

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome Back",
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold)),

                  SizedBox(height: 20),

                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        hintText: "Email", border: OutlineInputBorder()),
                    validator: (v) => auth.validateEmail(v!),
                  ),
                  SizedBox(height: 15),

                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password", border: OutlineInputBorder()),
                    validator: (v) => auth.validatePassword(v!),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: loginUser,
                    child: Text("Login"),
                  ),

                  SizedBox(height: 20),

                  InkWell(
                    onTap: () async {
                      User? user = await auth.signInWithGoogle();
                      if (user != null) setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/google.png", height: 24),
                          SizedBox(width: 10),
                          Text("Sign in with Google"),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignupScreen()));
                    },
                    child: Text("Create new account"),
                  ),
                ],
              ),
            ),
            ),
        );
    }
}