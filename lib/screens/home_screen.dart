import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? 'User';
    final username = userEmail.split('@')[0];
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          'Organic Basket',
          style: GoogleFonts.pacifico(
            textStyle: TextStyle(
              fontSize: screenWidth < 400 ? 22 : 26,
              color: Colors.white,
              shadows: const [
                Shadow(
                  blurRadius: 8,
                  color: Colors.black54,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
        actions: [
          const SizedBox(width: 12),
          Row(
            children: [
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const ProfileScreen()),
                  );
                },
                child: CircleAvatar(
                  radius: 18, // Larger avatar
                  backgroundColor: Colors.white.withAlpha(
                    80,
                  ), // Slightly more solid
                  child: Text(
                    username.isNotEmpty ? username[0].toUpperCase() : '?',
                    style: TextStyle(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,

                      fontSize: 16, // Slightly bigger font
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
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
