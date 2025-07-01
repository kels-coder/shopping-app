class Product {
  final String id;
  final String name;
  final String imageUrl;
  final int price;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory Product.fromFirestore(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] as num).toInt(),
      quantity: (data['quantity'] as num).toInt(),
    );
  }
}
