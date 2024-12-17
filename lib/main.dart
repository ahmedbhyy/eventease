import 'package:eventease/core/constant/color.dart';
import 'package:eventease/firebase_options.dart';
import 'package:eventease/local/local.dart';
import 'package:eventease/local/local_controller.dart';
import 'package:eventease/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

FlutterSecureStorage? secureStorage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  secureStorage = const FlutterSecureStorage();
  runApp(const EventEase());
}

class EventEase extends StatelessWidget {
  const EventEase({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return GetMaterialApp(
      title: 'EventEase',
      debugShowCheckedModeBanner: false,
      locale: controller.initiallang,
      translations: MyLocale(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.secondcolor),
        scaffoldBackgroundColor: AppColor.primarycolor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
