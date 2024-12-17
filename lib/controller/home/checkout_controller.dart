import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/view/commonwidgets/awesomedialog.dart';
import 'package:eventease/view/home/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckOutController extends GetxController {}

class CheckOutControllerImp extends CheckOutController {
  TextEditingController? controller1;
  TextEditingController? controller2;
  TextEditingController? controller3;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void onInit() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    controller1!.dispose();
    controller2!.dispose();
    controller3!.dispose();
    super.dispose();
  }

  bool isloading = false;
  pay(double total) async {
    isloading = true;
    update();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        CollectionReference cartRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart');

        CollectionReference ordersRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('orders');

        QuerySnapshot cartItems = await cartRef.get();
        Map<String, int> orderMap = {};

        for (QueryDocumentSnapshot item in cartItems.docs) {
          Map<String, dynamic> cartData = item.data() as Map<String, dynamic>;

          if (cartData.containsKey('name') &&
              cartData.containsKey('quantity')) {
            String productName = cartData['name'];
            int quantity = cartData['quantity'];

            orderMap[productName] = quantity;

            await item.reference.delete();
          }
        }
        if (orderMap.isNotEmpty) {
          await ordersRef.add({
            "orderItems": orderMap,
            "date": DateTime.now(),
            "Status": "En Cours",
            "total":total,
            "adress": controller2!.text,
            "phone": controller3!.text,
            "name": controller1!.text
          });
        }

        showAwesomeDialog(
            Get.context!, "Success", "Payment successful", DialogType.success);
        Get.offAll(const StartPage());
      } catch (e) {
        Get.snackbar("Error", "Failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      } finally {
        showAwesomeDialog(
            Get.context!, "Success", "Payment successful", DialogType.success);
        isloading = false;
        update();
      }
    }
  }
}
