import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:eventease/chooselanguage.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/main.dart';
import 'package:eventease/view/auth/sign_in.dart';
import 'package:eventease/view/home/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      final onboardingvisited =
          await secureStorage!.read(key: "onboardingvisited");
      (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified &&
              onboardingvisited == "1")
          ? Get.offAll(() => const StartPage())
          : (FirebaseAuth.instance.currentUser == null &&
                  onboardingvisited == "1")
              ? Get.offAll(() => const SignIn())
              : Get.offAll(() => const ChooseLanguage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInDown(
        delay: const Duration(milliseconds: 700),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  AppImageAsset.logo,
                  height: 130.0,
                ),
              ),
              Lottie.asset(AppImageAsset.loading, height: 80.0),
            ],
          ),
        ),
      ),
    );
  }
}
