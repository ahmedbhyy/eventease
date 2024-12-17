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
            "about usopjpoazjfpjôzegpozejdgkoap^dâpo^l^fdl^pead^pakf^paezkf^zeakfêzg",
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
