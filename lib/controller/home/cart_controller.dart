import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  checkCouponExists(String couponname);
}

class CartControllerImp extends CartController {
  bool isloading = false;
  bool couponexist = false;
  double couponremise = 0.0;
  TextEditingController couponController = TextEditingController();
  String couponname = '';

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  String? userId;
  @override
  void onInit() {
    userId = FirebaseAuth.instance.currentUser?.uid;
    super.onInit();
  }

  @override
  Future checkCouponExists(String couponname) async {
    try {
      isloading = true;
      update();
      final snapshot = await FirebaseFirestore.instance
          .collection('coupons')
          .where('couponname', isEqualTo: couponname)
          .get();

      if (snapshot.docs.isNotEmpty) {
        couponremise = snapshot.docs.first["remise"] + 0.0;
        isloading = false;
        couponexist = true;
        update();
      } else {
        isloading = false;
        Get.rawSnackbar(
          title: 'Error',
          message: 'Invalid coupon code.',
          backgroundColor: Colors.red,
        );
        update();
      }
    } catch (e) {
      isloading = false;
      update();
      return false;
    }
  }

  RxList<Map<String, dynamic>> cartItems = RxList<Map<String, dynamic>>([]);
  Stream<List<Map<String, dynamic>>> cartStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  void updatequantity(String productid, int quantity) async {
    if (userId != null) {
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("cart")
            .doc(productid)
            .set({
          "quantity": quantity,
        }, SetOptions(merge: true));
      } catch (e) {
        return;
      }
    }
  }

  removefromcart(String productid) async {
    if (userId != null) {
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("cart")
            .doc(productid)
            .delete();
      } catch (e) {
        return;
      }
    }
  }

  double calculateTotal() {
    double total = 0.0;
    for (var item in cartItems) {
      total += (item['prix']*(1-item['remise']/100)) *
          item[
              'quantity'];
    }
    return total;
  }
}
