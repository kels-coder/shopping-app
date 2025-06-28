import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser!.email ?? 'User';
    final username = userEmail.split('@')[0];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Shopping App'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
          fontSize: 24,
        ),
        actions: [
          Row(
            children: [
              Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (ctx) => ProfileScreen()));
                },
              ),
            ],
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
