import 'package:flutter/material.dart';

class UiScreen extends StatelessWidget {
  const UiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen"),
          backgroundColor: Colors.blue,
      ),
    );
  }
}
