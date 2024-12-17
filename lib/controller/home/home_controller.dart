import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/data/model/category_model.dart';
import 'package:eventease/data/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  Future<void> getAllProducts();
  CategoryModel changecategorie(String categoriename);
}

class HomeControllerImp extends HomeController {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  late String dropdownvalue;
  String selectedcategorie = "All";
  final userId = FirebaseAuth.instance.currentUser?.uid;

  RxList<ProductModel> favoriteProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    getAllProducts();
    loadFavorites();
    super.onInit();
    dropdownvalue = list.first;
  }

  void loadFavorites() {
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favoriteProducts')
          .snapshots()
          .listen((snapshot) {
        try {
          favoriteProducts.value = snapshot.docs
              .where((doc) => doc.exists)
              .map((doc) {
                try {
                  return ProductModel.fromFirestore(doc);
                } catch (e) {
                  return null;
                }
              })
              .where((product) => product != null)
              .cast<ProductModel>()
              .toList();
          update();
        } catch (e) {
          Get.rawSnackbar(
              title: "Error",
              message: "Failed to load favorites",
              backgroundColor: AppColor.redcolor);
        }
      });
    } else {
      Get.rawSnackbar(
          title: "Error",
          message: "Failed!",
          backgroundColor: AppColor.redcolor);
    }
  }

  bool isloading = false;
  List<CategoryModel> categories = [];
  List<ProductModel> allProducts = [];

  @override
  Future<void> getAllProducts() async {
    try {
      categories.clear();
      allProducts.clear();
      isloading = true;
      update();

      final allCategory = CategoryModel(
        name: "All",
        image: "https://cdn-icons-png.flaticon.com/512/5619/5619329.png",
        products: allProducts,
      );
      categories.add(allCategory);

      final categorySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      for (var categoryDoc in categorySnapshot.docs) {
        // ignore: unnecessary_cast
        final categoryData = categoryDoc.data() as Map<String, dynamic>;
        final category = CategoryModel(
          name: categoryData['name'] ?? 'Unknown Category',
          image: categoryData['image'] ?? '',
          products: [],
        );

        final productSnapshot =
            await categoryDoc.reference.collection('products').get();

        for (var productDoc in productSnapshot.docs) {
          final product = ProductModel.fromFirestore(productDoc);
          category.products.add(product);
          allProducts.add(product);
        }

        categories.add(category);
      }

      selectedcategorie = categories[0].name;
    } catch (e) {
      Get.rawSnackbar(title: "Error $e", message: "Please try again");
    } finally {
      isloading = false;
      update();
    }
  }

  @override
  CategoryModel changecategorie(String categoriename) {
    if (categoriename == "All") {
      final allCategory = categories.firstWhere(
        (category) => category.name == "All",
        orElse: () => CategoryModel(name: "All", image: '', products: []),
      );
      return allCategory;
    } else {
      final category = categories.firstWhere(
        (category) => category.name == categoriename,
        orElse: () => CategoryModel(name: '', image: '', products: []),
      );
      return category;
    }
  }

  CategoryModel getCategoryForProduct(ProductModel product) {
    return categories.firstWhere(
      (category) =>
          category.products.contains(product) && category.name != "All",
      orElse: () => CategoryModel(name: 'Unknown', image: '', products: []),
    );
  }

  bool isFavorite(ProductModel product) {
    return favoriteProducts.any((fav) => fav.id == product.id);
  }

  void toggleFavorite(ProductModel product) async {
    if (userId != null) {
      final favoritesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favoriteProducts')
          .doc(product.id);

      try {
        if (isFavorite(product)) {
          await favoritesRef.delete();
          favoriteProducts.removeWhere((fav) => fav.id == product.id);
        } else {
          await favoritesRef.set({
            'id': product.id,
            'name': product.name,
            'prix': product.prix,
            'remise': product.remise,
            'image': product.image,
          });
          favoriteProducts.add(product);
        }
        update();
        Get.rawSnackbar(
            title: "Success",
            message: "Favorites updated",
            backgroundColor: AppColor.redcolor);
      } catch (e) {
        Get.rawSnackbar(
            title: "Error",
            message: "Failed to update favorites",
            backgroundColor: AppColor.redcolor);
      }
    }
  }
}
