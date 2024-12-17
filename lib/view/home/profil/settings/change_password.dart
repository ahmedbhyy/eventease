import 'package:eventease/controller/settings/change_password_controller.dart';
import 'package:eventease/core/constant/color.dart';

import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/auth/authwidgets/button_auth.dart';
import 'package:eventease/view/auth/authwidgets/textfieldauth.dart';

import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordControllerImp controller =
        Get.put(ChangePasswordControllerImp());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Password",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Form(
        key: controller.formStatechangepassword,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            Image.asset(
              AppImageAsset.password,
            ),
            TextFieldAuth(
              hint: "Current password",
              mycontroller: controller.oldpassword!,
              myicon: const Icon(
                LineIcons.key,
                color: AppColor.secondcolor,
              ),
              ispass: true,
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
              height: 5.0,
            ),
            TextFieldAuth(
              hint: "New password",
              mycontroller: controller.newpassword!,
              myicon: const Icon(
                LineIcons.key,
                color: AppColor.secondcolor,
              ),
              ispass: true,
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
              height: 5.0,
            ),
            TextFieldAuth(
              hint: "Confirm new password",
              mycontroller: controller.confirmnewpassword!,
              myicon: const Icon(
                LineIcons.key,
                color: AppColor.secondcolor,
              ),
              ispass: true,
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
              height: 35.0,
            ),
            ButtonAuth(
              mytitle: "Update",
              myfunction: () {
                if (controller.formStatechangepassword.currentState!
                    .validate()) {
                  controller.changepassword(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
