import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/profile_screen.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String username) {
  final screenWidth = MediaQuery.of(context).size.width;

  return AppBar(
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    title: Padding(
      padding: EdgeInsets.only(right: screenWidth < 400 ? 20 : 40),
      child: Text(
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

            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (ctx) => CartScreen()));
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
                Text(
                  'Profile',
                  style: GoogleFonts.pacifico(
                    textStyle: TextStyle(
                      fontSize: screenWidth < 400 ? 16 : 14,
                      fontWeight: FontWeight.w500,
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
                const SizedBox(width: 6),
                CircleAvatar(
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
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
