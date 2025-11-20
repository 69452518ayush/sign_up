import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_up/registration_screen.dart';
import 'package:sign_up/ui_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _islogin = true;
  bool _isloading = false;
  Future<void> _submitAuthForm() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      _showError("Please fill in all fields ");
      return;
    }
    setState(() => _isloading = true);
    try {
      UserCredential userCredential;
      if (_islogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      if (userCredential.user != null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RegistrationScreen()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        _showError("No user found for that email");
      } else if (e.code == 'wrong password') {
        _showError("Wrong Password. Please try again");
      } else if (e.code == 'Weak Password') {
        _showError("Password should be at 6 characters ");
      } else {
        _showError("Authentication failed : ${e.message}");
      }
    } catch (e) {
      _showError("Something went wrong.Try again");
    }
    setState(() => _isloading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 100,),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your email' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) =>
                          value!.length < 6 ? 'Please enter Password' : null,
                    ),
                    SizedBox(height: 200,),
                    ElevatedButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UiScreen()));
                    }, child: Text("Login")),
                    ElevatedButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationScreen()));
                    }, child: Text("Registration Screen")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
