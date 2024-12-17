import 'package:eventease/controller/profil/profil_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/view/commonwidgets/commonrowprofil.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ProfilControllerImp());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: GetBuilder<ProfilControllerImp>(
          builder: (controller) => ListView(
            children: [
              Text(
                "Profil",
                style: GoogleFonts.mulish(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: AppColor.secondcolor,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: CircleAvatar(
                  radius: 65.0,
                  backgroundColor: AppColor.secondcolor,
                  backgroundImage: NetworkImage(
                    controller.userpic,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ...List.generate(
                controller.options.length,
                (index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      SlideRight(page: controller.categoriespages[index]),
                    );
                  },
                  child: CommonRowProfil(
                    title: controller.options[index]["title"],
                    myicon: controller.options[index]["icon"],
                    description: controller.options[index]["description"],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 80.0, vertical: 20.0),
                child: MaterialButton(
                  onPressed: () {
                    controller.logout();
                  },
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(67, 0, 0, 0),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: AppColor.redcolor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout_rounded,
                        color: AppColor.secondcolor,
                      ),
                      Text(
                        "Logout",
                        style: GoogleFonts.mulish(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondcolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
