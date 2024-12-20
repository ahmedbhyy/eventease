import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constant/color.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "About Us",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Image.asset(
            AppImageAsset.aboutus,
          ),
          Text(
            "EventEase is your go-to mobile app designed to simplify event planning and management. Whether you’re organizing a wedding, corporate event, or any special occasion, we provide a seamless platform to help you rent, organize, and manage your event needs with ease.Our mission is to make event planning stress-free by offering a wide range of services, from venue rentals to equipment, all available at your fingertips. With EventEase, you can browse, book, and coordinate every aspect of your event, ensuring a memorable experience.We are passionate about delivering innovation, quality, and service, offering tailored solutions to fit every event. Let us help you create unforgettable moments!",
            style: GoogleFonts.mulish(
              fontSize: 18.0,
              color: AppColor.secondcolor,
            ),
          ),
        ],
      ),
    );
  }
}
