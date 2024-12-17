import 'package:animate_do/animate_do.dart';
import 'package:eventease/controller/auth/sign_up_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/auth/authwidgets/button_auth.dart';
import 'package:eventease/view/auth/authwidgets/common_row_down.dart';
import 'package:eventease/view/auth/authwidgets/common_text_auth.dart';
import 'package:eventease/view/auth/authwidgets/textfieldauth.dart';
import 'package:eventease/view/commonwidgets/commonloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpControllerImp controller = Get.put(SignUpControllerImp());
    return Scaffold(
      backgroundColor: AppColor.redcolor,
      body: Form(
        key: controller.formStatesingup,
        child: SafeArea(
          child: GetBuilder<SignUpControllerImp>(
            builder: (controller) => ListView(
              children: [
                const Commonauthtextsign(
                  textsign: "Sign Up",
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColor.primarycolor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                        child: FadeInRight(
                          duration: const Duration(seconds: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome to us",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.mulish(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.secondcolor,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  AppImageAsset.logo,
                                  height: 50.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: FadeInRight(
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            "Hello there,create new account",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.mulish(
                              fontSize: 20.0,
                              color: AppColor.greycolor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Center(
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 800),
                          child: Image.asset(
                            AppImageAsset.signup,
                            height: 200.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FadeInRight(
                          duration: const Duration(milliseconds: 800),
                          child: TextFieldAuth(
                            hint: "Username",
                            readonly: false,
                            mytype: TextInputType.text,
                            mycontroller: controller.usernamecontroller,
                            myicon: const Icon(
                              LineIcons.user,
                              color: AppColor.secondcolor,
                            ),
                            ispass: false,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Can't to be empty ";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FadeInRight(
                          duration: const Duration(milliseconds: 800),
                          child: TextFieldAuth(
                            hint: "Email",
                            readonly: false,
                            mytype: TextInputType.emailAddress,
                            mycontroller: controller.emailcontroller,
                            myicon: const Icon(
                              LineIcons.mailBulk,
                              color: AppColor.secondcolor,
                            ),
                            ispass: false,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Can't to be empty ";
                              } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(val)) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 800),
                          child: TextFieldAuth(
                            hint: "Password",
                            readonly: false,
                            mytype: TextInputType.text,
                            mycontroller: controller.passwordcontroller,
                            mysuffixicon: GestureDetector(
                              onTap: () {
                                controller.hidepaasword();
                              },
                              child: Icon(
                                controller.isPasswordHidden
                                    ? LineIcons.eyeSlash
                                    // ignore: dead_code
                                    : LineIcons.eye,
                                color: AppColor.secondcolor,
                              ),
                            ),
                            myicon: const Icon(
                              LineIcons.key,
                              color: AppColor.secondcolor,
                            ),
                            ispass: controller.isPasswordHidden,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Can't to be empty ";
                              } else if (val.length < 8) {
                                return 'Weak password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 800),
                          child: TextFieldAuth(
                            hint: "Confirm Password",
                            readonly: false,
                            mytype: TextInputType.text,
                            mycontroller: controller.repasswordcontroller,
                            mysuffixicon: GestureDetector(
                              onTap: () {
                                controller.hiderepaasword();
                              },
                              child: Icon(
                                controller.isrePasswordHidden
                                    ? LineIcons.eyeSlash
                                    : LineIcons.eye,
                                color: AppColor.secondcolor,
                              ),
                            ),
                            myicon: const Icon(
                              LineIcons.key,
                              color: AppColor.secondcolor,
                            ),
                            ispass: controller.isrePasswordHidden,
                            validator: (val) {
                              controller.validatePassword(
                                val!,
                              );
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      controller.isloading
                          ? const CommonLoading()
                          : FadeInRight(
                              duration: const Duration(milliseconds: 900),
                              child: ButtonAuth(
                                mytitle: "Sign Up",
                                myfunction: () {
                                  if (controller.formStatesingup.currentState!
                                      .validate()) {
                                    controller.signup(
                                      controller.emailcontroller.text,
                                      controller.passwordcontroller.text,
                                      context,
                                    );
                                  }
                                },
                              ),
                            ),
                      const SizedBox(height: 40.0),
                      CommonRowDown(
                        onTap: () => controller.gotosignIn(context),
                        textrowone: "Already have an account?  ",
                        textrowtwo: "Sign In",
                      ),
                      const SizedBox(height: 10.0)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
