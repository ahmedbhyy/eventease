import 'package:eventease/controller/profil/contact_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:eventease/view/home/profil/chat.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContactControllerImp controller = Get.put(ContactControllerImp());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            SlideRight(
              page: const ChatScreen(),
            ),
          );
        },
        backgroundColor: AppColor.redcolor,
        child: const Icon(
          Icons.chat,
          color: AppColor.secondcolor,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Contact",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Image.asset(
            AppImageAsset.contact,
          ),
          Text(
            "We're here to assist you in any way we can. Reach out to us via Facebook, Instagram, email, or phone to connect with our dedicated customer support team. Whether you have questions about your account, need help with our services, or want to provide feedback, we're ready to assist you.",
            style: GoogleFonts.mulish(
              fontSize: 17.0,
              color: AppColor.secondcolor,
            ),
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                controller.contactimages.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () async {
                      index == 0
                          ? await controller.callphone(controller.urls[0])
                          : index == 3
                              ? await controller.sendemail(controller.urls[3])
                              : await controller.launchurl(
                                  Uri.parse(
                                    controller.urls[index],
                                  ),
                                );
                    },
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color.fromARGB(255, 211, 209, 203),
                      child: Image.asset(
                        controller.contactimages[index],
                        height: 40.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
