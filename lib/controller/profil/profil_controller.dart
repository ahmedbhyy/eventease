import 'package:eventease/view/auth/sign_in.dart';
import 'package:eventease/view/home/profil/contact.dart';
import 'package:eventease/view/home/profil/orders.dart';
import 'package:eventease/view/home/profil/edit_profil.dart';
import 'package:eventease/view/home/profil/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';

abstract class ProfilController extends GetxController {
  logout();
}

class ProfilControllerImp extends ProfilController {
  List<Widget> categoriespages = [];
  ProfilControllerImp() {
    categoriespages = [
      const EditProfil(),
      const OrdersScreen(),
      const SettingsScreen(),
      const ContactScreen()
    ];
  }

  String userpic = "https://cdn-icons-png.freepik.com/512/3001/3001764.png";

  List options = [
    {
      "title": "Profil",
      "description": "edit your profil",
      "icon": const Icon(LineIcons.user),
    },
    {
      "title": "My Orders",
      "description": "View Orders details",
      "icon": const Icon(Icons.shopping_bag_outlined),
    },
    {
      "title": "Settings",
      "description": "change settings",
      "icon": const Icon(Icons.settings),
    },
    {
      "title": "Contact",
      "description": "Contact Us",
      "icon": const Icon(Icons.email_outlined),
    },
  ];

  @override
  logout() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const SignIn());
    } catch (e) {
      return;
    }
  }
}
