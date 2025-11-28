import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_up/auth_service.dart';


class HomeScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => auth.logout()),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: user.photoURL != null
                    ? NetworkImage(user.photoURL!)
                    : null,
                child: user.photoURL == null
                    ? Icon(Icons.person, size: 45)
                    : null,
              ),

              SizedBox(height: 20),
              Text(
                user.displayName ?? "No Name",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Text(user.email!, style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email Verified",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      user.emailVerified ? Icons.check_circle : Icons.cancel,
                      color: user.emailVerified ? Colors.green : Colors.red,
                    ),
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
