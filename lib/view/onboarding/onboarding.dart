import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/auth/sign_in.dart';
import 'package:eventease/view/auth/sign_up.dart';
import 'package:eventease/view/onboarding/onboarding_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Register',
      finishButtonTextStyle: GoogleFonts.mulish(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: AppColor.secondcolor,
      ),
      skipIcon: const Icon(LineIcons.arrowRight, color: AppColor.secondcolor),
      onFinish: () {
        Get.offAll(() => const SignUp());
      },
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: AppColor.redcolor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      skipTextButton: Text(
        'Skip',
        style: GoogleFonts.mulish(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColor.redcolor,
        ),
      ),
      trailing: Text(
        'Login',
        style: GoogleFonts.mulish(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColor.redcolor,
        ),
      ),
      trailingFunction: () {
        Get.offAll(() => const SignIn());
      },
      controllerColor: AppColor.primarycolor,
      totalPage: 2,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Lottie.asset(
          AppImageAsset.onboarding1,
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.95,
        ),
        Lottie.asset(
          AppImageAsset.onboarding2,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ],
      speed: 1.8,
      pageBodies: const [
        Onboardingcontainer(
          textone: 'On your way...',
          texttwo: 'to find the perfect looking Onboarding for your app?',
        ),
        Onboardingcontainer(
          textone: 'Start now!',
          texttwo:
              'Where everything is possible and customize your onboarding.',
        ),
      ],
    );
  }
}
