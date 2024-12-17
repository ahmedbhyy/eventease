import 'package:eventease/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class CommonRowProfil extends StatelessWidget {
  final String title;
  final String description;
  final Icon myicon;
  final Switch? switche;
  const CommonRowProfil(
      {super.key,
      required this.title,
      required this.myicon,
      required this.description,
      this.switche});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  myicon,
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.mulish(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primarycolor,
                        ),
                      ),
                      Text(
                        description,
                        style: GoogleFonts.mulish(
                          fontSize: 14.0,
                          color: const Color.fromARGB(255, 148, 138, 138),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              switche ??
                  const Icon(
                    LineIcons.arrowCircleRight,
                    color: Color.fromARGB(255, 172, 161, 161),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
