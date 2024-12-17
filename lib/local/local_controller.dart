import 'dart:ui';

import 'package:eventease/main.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  // ignore: unrelated_type_equality_checks
  Locale initiallang = secureStorage!.read(key: "lang") == "fr"
      ? const Locale("fr")
      : const Locale("en");

  void changelang(String langcode) {
  Locale locale = Locale(langcode);
  secureStorage!.write(key: "lang", value: langcode);
  Get.updateLocale(locale);
  }
}
