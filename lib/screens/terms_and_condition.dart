import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'These are the terms and conditions for using the app...',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
