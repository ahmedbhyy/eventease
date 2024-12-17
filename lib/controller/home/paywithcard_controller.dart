import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/view/commonwidgets/awesomedialog.dart';

import 'package:eventease/view/home/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

abstract class PayWithCardController extends GetxController {}

class PayWithCardControllerImp extends PayWithCardController {
  TextEditingController? controller1;
  TextEditingController? controller2;
  TextEditingController? controller3;
  TextEditingController? controller4;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void onInit() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    controller1!.dispose();
    controller2!.dispose();
    controller3!.dispose();
    controller4!.dispose();

    super.dispose();
  }

  bool isloading = false;

  void updateCardData(CreditCardModel data) {
    controller1!.text = data.cardNumber;
    controller2!.text = data.expiryDate;
    controller3!.text = data.cardHolderName;
    controller4!.text = data.cvvCode;
    update();
  }

  pay(double total ,String name ,String adress,String phone) async {
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
            "total": total,
            "adress": adress,
            "phone":phone,
            "name": name,
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
