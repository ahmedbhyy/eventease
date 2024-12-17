import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/data/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class FavoritesController extends GetxController {}

class FavoritesControllerImp extends FavoritesController {
  TextEditingController searchController = TextEditingController();

  final userId = FirebaseAuth.instance.currentUser?.uid;
  bool isloading = false;

  RxList<ProductModel> favoriteProducts = <ProductModel>[].obs;
  List<ProductModel> filteredProducts = [];

  loadFavorites() {
    if (userId != null) {
      isloading = true;
      update();
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
          filteredProducts = favoriteProducts;
          isloading = false;

          update();
        } catch (e) {
          isloading = false;
          update();
          Get.rawSnackbar(
              title: "Error",
              message: "Failed to load favorites",
              backgroundColor: AppColor.redcolor);
        }
      });
    } else {
      isloading = false;
      update();
      Get.rawSnackbar(
          title: "Error",
          message: "Failed!",
          backgroundColor: AppColor.redcolor);
    }
  }

  void filterProducts(String query) {
    filteredProducts = favoriteProducts
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }
}
