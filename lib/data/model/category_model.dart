import 'package:eventease/data/model/product_model.dart';

class CategoryModel {
  final String name;
  final String image;
  final List<ProductModel> products;

  CategoryModel({
    required this.name,
    required this.image,
    required this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      products: json['products']?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'products':products,
    };
  }
}
