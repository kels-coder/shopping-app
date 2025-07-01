import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/products.dart';

Future<List<Product>> fetchProductsFromFirestore() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('products')
      .get();

  return snapshot.docs.map((doc) {
    final data = doc.data();
    return Product.fromFirestore(doc.id, data);
  }).toList();
}
