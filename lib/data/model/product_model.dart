import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String name;
  final String image;
  final String id;
  final double prix;
  final double remise;

  ProductModel({
    required this.name,
    required this.id,
    required this.image,
    required this.remise,
    required this.prix,
  });

  // Factory method to create a ProductModel instance from a Firestore document
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      remise: (json['remise'] ?? 0.0)
          .toDouble(), // Safely handle null and cast to double
      prix: (json['prix'] ?? 0.0)
          .toDouble(), // Safely handle null and cast to double
    );
  }

  // Converts a Firestore document into a ProductModel
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      name: data['name'] ?? 'Product',
      id: doc.id, // Firestore document ID
      image: data['image'] ?? 'https://cdn-icons-png.flaticon.com/512/3787/3787917.png',
      remise: (data['remise'] ?? 0.0)
          .toDouble(), 
      prix: (data['prix'] ?? 0.0)
          .toDouble(), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'image': image,
      'prix': prix,
      'remise': remise,
    };
  }


  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'image':image,
      'name': name,
      'prix': prix,
      'remise':remise,
      'quantity':
          1, 
    
    };
  }

}
