import 'package:eventease/main.dart';
import 'package:eventease/view/home/cart.dart';
import 'package:eventease/view/home/favorite_screen.dart';
import 'package:eventease/view/home/home_screen.dart';
import 'package:eventease/view/home/notifications.dart';
import 'package:eventease/view/home/profil_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class StartController extends GetxController {
  void generatewindow(int i);
}

class StartControllerImp extends StartController {
  int selectedIndex = 0;
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  List<Widget> listPage = [
    const HomeScreen(),
    const FavoritesScreen(),
    const CartScreen(),
     const ProfilScreen(),
  ];

  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  StartControllerImp() {
    listenToCart();
  }



  @override
  generatewindow(int i) {
    selectedIndex = i;
    update();
  }

  listenToCart() {
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .snapshots()
          .listen((snapshot) {
        try {
          cartItems.value = snapshot.docs.map((doc) {
            return doc.data();
          }).toList();
          update();
        } catch (e) {
          return;
        }
      });
    } else {
      return;
    }
  }

  @override
  void onInit() async {
    
    FirebaseMessaging.instance.subscribeToTopic('eventease');
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.to( NotificationsScreen());
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        Get.snackbar(
            "${message.notification!.title}", "${message.notification!.body}");
      }
    });
    gettoken();
    super.onInit();
  }

  gettoken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance.collection('users').doc(userId).set(
      {
        'token': token,
        'isadmin': false,
      },
      SetOptions(merge: true),
    );
    await secureStorage!.write(
      key: "usertoken",
      value: token,
    );
  }

  
}
