import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/local/local_controller.dart';
import 'package:eventease/view/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controllerlang = Get.find();
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 4.5,
        ),
        children: [
          Column(
            children: [
              Image.asset(AppImageAsset.language),
              Text(
                "Choose language",
                style: GoogleFonts.mulish(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: AppColor.secondcolor,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      controllerlang.changelang("en");
                      Get.off(()=>const OnBoarding());
                    },
                    shape: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(67, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: AppColor.redcolor,
                    child: Text(
                      "English",
                      style: GoogleFonts.mulish(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColor.secondcolor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  MaterialButton(
                    onPressed: () {
                      controllerlang.changelang("fr");
                      Get.off(()=>const OnBoarding());
                    },
                    shape: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(67, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: AppColor.greycolor,
                    child: Text(
                      "French",
                      style: GoogleFonts.mulish(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColor.secondcolor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
