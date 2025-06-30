import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Padding(
          padding: EdgeInsets.only(right: screenWidth < 400 ? 20 : 40),
          child: Text(
            'cart screen',
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
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        child: const Center(
          child: Text('This is the CartScreen', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
