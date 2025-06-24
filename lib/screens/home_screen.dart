import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _firebase = FirebaseAuth.instance;

  void _logout() {
    _firebase.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // ✅ Let body go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(
          0.95,
        ), // ✅ slightly transparent
        elevation: 0,
        centerTitle: true,
        title: const Text('Shopping App'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
          fontSize: 24,
        ),
        actions: [
          TextButton(
            onPressed: _logout,
            child: const Text(
              'Logout',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        child: const Center(
          child: Text('This is the HomeScreen', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
