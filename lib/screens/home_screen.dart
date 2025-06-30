import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/appbar_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? 'User';
    final username = userEmail.split('@')[0];
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: buildAppBar(context, username),
      body: Text('This is the HomeScreen'),
    );
  }
}
