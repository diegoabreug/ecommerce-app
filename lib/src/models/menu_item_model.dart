import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItemModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory MenuItemModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MenuItemModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      // Manejamos seguridad en el precio por si viene como String o Int
      price: (data['price'] is int)
          ? (data['price'] as int).toDouble()
          : double.tryParse(data['price'].toString()) ?? 0.0,
      imageUrl: data['image'] ?? '',
      category: data['category'] ?? 'General',
    );
  }
}