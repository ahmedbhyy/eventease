import 'package:eventease/controller/home/checkout_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/auth/authwidgets/button_auth.dart';
import 'package:eventease/view/auth/authwidgets/textfieldauth.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:eventease/view/commonwidgets/commonloading.dart';
import 'package:eventease/view/home/paywithcard.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOut extends StatelessWidget {
  final double total;
  const CheckOut({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    CheckOutControllerImp controller = Get.put(CheckOutControllerImp());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Check Out",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Form(
        key: controller.formState,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            Image.asset(
              AppImageAsset.checkout,
              height: 250.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFieldAuth(
              hint: "Name",
              mycontroller: controller.controller1!,
              myicon: const Icon(
                Icons.person_2_outlined,
                color: AppColor.secondcolor,
              ),
              ispass: false,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Can't to be empty ";
                }
                return null;
              },
              mytype: TextInputType.text,
              readonly: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFieldAuth(
              hint: "Place",
              mycontroller: controller.controller2!,
              myicon: const Icon(
                Icons.place_outlined,
                color: AppColor.secondcolor,
              ),
              ispass: false,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Can't to be empty ";
                }
                return null;
              },
              mytype: TextInputType.text,
              readonly: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFieldAuth(
              hint: "Phone number",
              mycontroller: controller.controller3!,
              myicon: const Icon(
                Icons.phone,
                color: AppColor.secondcolor,
              ),
              prefixtext: "+216 ",
              ispass: false,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Can't to be empty ";
                }
                return null;
              },
              mytype: TextInputType.text,
              readonly: false,
            ),
            const SizedBox(
              height: 50.0,
            ),
            ButtonAuth(
              mytitle: "Pay with card",
              myfunction: () {
                if (controller.formState.currentState!.validate()) {
                  Navigator.of(context).push(
                    SlideRight(
                      page: PayWithCard(
                        total: total,
                        adress: controller.controller2!.text,
                        name: controller.controller2!.text,
                        phone: controller.controller3!.text,
                      ),
                    ),
                  );
                }
              },
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Or",
                  style: GoogleFonts.mulish(
                    fontSize: 20.0,
                    color: AppColor.secondcolor,
                  ),
                ),
              ),
            ),
            controller.isloading
                ? const CommonLoading()
                : ButtonAuth(
                    mytitle: "Cash on Delivery",
                    myfunction: () {
                      if (controller.formState.currentState!.validate()) {
                        controller.pay(total);
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
