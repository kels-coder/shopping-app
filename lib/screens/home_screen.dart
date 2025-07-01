import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/models/products.dart';
import 'package:shopping_app/screen_logics/product_item.dart';
import 'package:shopping_app/screen_logics/products_service.dart';
import 'package:shopping_app/screens/appbar_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? 'User';
    final username = userEmail.split('@')[0];

    return Scaffold(
      appBar: buildAppBar(context, username),
      body: FutureBuilder<List<Product>>(
        future: fetchProductsFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading products'));
          }

          final products = snapshot.data ?? [];

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) => ProductItem(product: products[index]),
          );
        },
      ),
    );
  }
}
