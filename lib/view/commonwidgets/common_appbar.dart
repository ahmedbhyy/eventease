import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const CommonAppBar({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.mulish(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: AppColor.secondcolor,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              AppImageAsset.logo,
              height: 40.0,
            ),
          ),
        ),
      ],
      scrolledUnderElevation: 0,
      backgroundColor: AppColor.primarycolor,
      centerTitle: true,
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back_ios_new),
        color: AppColor.redcolor,
      ),
    );
  }
}
