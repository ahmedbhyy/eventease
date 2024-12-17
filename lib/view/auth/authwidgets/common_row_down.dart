import 'package:animate_do/animate_do.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonRowDown extends StatelessWidget {
  final void Function() onTap;
  final String textrowone;
  final String textrowtwo;
  const CommonRowDown(
      {super.key,
      required this.onTap,
      required this.textrowone,
      required this.textrowtwo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeInLeft(
          duration: const Duration(milliseconds: 900),
          child: Text(
            textrowone,
            style: GoogleFonts.mulish(
              fontSize: 17.0,
              color: AppColor.greycolor,
            ),
          ),
        ),
        FadeInRight(
          duration: const Duration(milliseconds: 900),
          child: InkWell(
            onTap: onTap,
            child: Text(
              textrowtwo,
              style: GoogleFonts.mulish(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColor.secondcolor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
