import 'package:animate_do/animate_do.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Commonauthtextsign extends StatelessWidget {
  final String textsign;
  const Commonauthtextsign({super.key, required this.textsign});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 15.0),
        child: Text(
          textsign,
          textAlign: TextAlign.start,
          style: GoogleFonts.almarai(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: AppColor.primarycolor,
          ),
        ),
      ),
    );
  }
}
