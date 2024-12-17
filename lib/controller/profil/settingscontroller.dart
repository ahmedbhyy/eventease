import 'package:eventease/view/home/profil/settings/aboutus.dart';
import 'package:eventease/view/home/profil/settings/change_password.dart';
import 'package:eventease/view/home/profil/settings/language.dart';
import 'package:eventease/view/home/profil/settings/privacy.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';

import '../../main.dart';

abstract class SettingsController extends GetxController {}

class SettingsControllerImp extends SettingsController {
  List<Widget> categoriespages = [];
  bool notificationactive = true;
  SettingsControllerImp() {
    categoriespages = [
      const LanguageScreen(),
      const ChangePassword(),
      const PrivacyScreen(),
      const AboutUs(),
    ];
  }
  @override
  void onInit() async {
    String? noti = await secureStorage!.read(
      key: "notifications",
    );
    notificationactive = noti == "1" ? true : false;
    super.onInit();
  }

  List options = [
    {
      "title": "Language",
      "description": "Change Language",
      "icon": const Icon(LineIcons.language),
    },
    {
      "title": "Password",
      "description": "Change Password",
      "icon": const Icon(LineIcons.key),
    },
    {
      "title": "Privacy",
      "description": "privacy",
      "icon": const Icon(Icons.privacy_tip_outlined),
    },
    {
      "title": "About Us",
      "description": "about us",
      "icon": const Icon(Icons.help_outline_outlined),
    },
  ];
}
