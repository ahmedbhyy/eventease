import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Privacy",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Image.asset(AppImageAsset.privacy),
          Text(
            "At EventEase, we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard the information you provide when using our app.We collect personal data such as name, contact details, and payment information to process orders and improve your experience. We use this data solely for the purpose of delivering our services and ensuring seamless communication with you. We do not share your personal information with third parties unless required by law or to provide you with necessary services, such as payment processing or customer support.Your data is stored securely, and we implement reasonable measures to protect it from unauthorized access or misuse.By using EventEase, you consent to the terms outlined in this Privacy Policy. If you have any questions or concerns, please contact us.",
            style: GoogleFonts.mulish(
              fontSize: 18.0,
              color: AppColor.secondcolor,
            ),
          )
        ],
      ),
    );
  }
}
