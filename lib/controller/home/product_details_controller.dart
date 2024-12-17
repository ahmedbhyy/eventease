import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/data/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../core/constant/color.dart';

abstract class ProductDetailsController extends GetxController {
  getAllCartProducts();
}

class ProductDetailsControllerImp extends ProductDetailsController {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  bool isloading = false;

  List<String> productsid = [];
  @override
  void onInit() {
    getAllCartProducts();
    super.onInit();
  }

  @override
  void getAllCartProducts() async {
    if (userId != null) {
      try {
        isloading = true;
        update();
        QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .get();

        productsid = cartSnapshot.docs.map((doc) => doc.id).toList();
        isloading = false;
        update();
      } catch (e) {
        isloading = false;
        update();
        return null;
      }
    } else {
      isloading = false;
      update();
      return null;
    }
  }

  void toggleFavorite(ProductModel product, bool isFavorite) async {
    if (userId != null) {
      final favoritesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favoriteProducts')
          .doc(product.id);

      try {
        if (isFavorite) {
          await favoritesRef.delete();
        } else {
          await favoritesRef.set({
            'id': product.id,
            'name': product.name,
            'prix': product.prix,
            'remise': product.remise,
            'image': product.image,
          });
        }
        isFavorite = !isFavorite;
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

  void addToCart(ProductModel product) async {
    if (userId != null) {
      try {
        Map<String, dynamic> productData = product.toFirestore();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(product.id)
            .set(productData);
        productsid.add(product.id);
        update();
      } catch (e) {
        Get.rawSnackbar(
          title: "Error",
          message: "Failed to add product from cart",
          backgroundColor: AppColor.redcolor,
        );
      }
    } else {
      Get.rawSnackbar(
        title: "Error",
        message: "Please log in to add products to your cart",
        backgroundColor: AppColor.redcolor,
      );
    }
  }

  void removeFromCart(String productId) async {
    if (userId != null) {
      try {
        DocumentReference productRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(productId);

        await productRef.delete();
        productsid.remove(productId);
        update();
      } catch (e) {
        Get.rawSnackbar(
          title: "Error",
          message: "Failed to remove product from cart",
          backgroundColor: AppColor.redcolor,
        );
      }
    } else {
      Get.rawSnackbar(
        title: "Error",
        message: "Please log in to manage your cart",
        backgroundColor: AppColor.redcolor,
      );
    }
  }
}
