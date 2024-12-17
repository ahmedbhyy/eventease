import 'package:animate_do/animate_do.dart';
import 'package:eventease/controller/auth/sign_in_controller.dart';
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

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    SignInControllerImp controller = Get.put(SignInControllerImp());
    return Scaffold(
      backgroundColor: AppColor.redcolor,
      body: Form(
        key: controller.formStateSignIn,
        child: SafeArea(
          child: ListView(
            children: [
              const Commonauthtextsign(
                textsign: "Sign In",
              ),
              GetBuilder<SignInControllerImp>(
                builder: (controller) => Container(
                  height: MediaQuery.of(context).size.height * 0.9,
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
                                "Welcome Back",
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
                            "Hello there,sign in to continue",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.mulish(
                              fontSize: 17.0,
                              color: AppColor.greycolor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Center(
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 800),
                          child: Image.asset(
                            AppImageAsset.signin,
                            height: 200.0,
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
                              LineIcons.user,
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
                                controller.ispasswordhidden
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
                            ispass: controller.ispasswordhidden,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Can't to be empty ";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      controller.isloading2
                          ? const CommonLoading()
                          : InkWell(
                              onTap: () {
                                if (controller.emailcontroller.text == "" ||
                                    controller.emailcontroller.text.isEmpty) {
                                  Get.rawSnackbar(
                                      title: "Error",
                                      message: "Please write your email",
                                      backgroundColor: Colors.red);
                                } else {
                                  controller.forgetpassword(
                                      controller.emailcontroller.text,context);
                                }
                              },
                              child: FadeInLeft(
                                duration: const Duration(milliseconds: 800),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 1.7,
                                    top: 10.0,
                                  ),
                                  child: const Text(
                                    "Forget Password ?",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: AppColor.secondcolor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 25.0),
                      controller.isloading1
                          ? const CommonLoading()
                          : FadeInRight(
                              duration: const Duration(milliseconds: 900),
                              child: ButtonAuth(
                                mytitle: "Sign In",
                                myfunction: () {
                                  if (controller.formStateSignIn.currentState!
                                      .validate()) {
                                    controller.signin(
                                        controller.emailcontroller.text,
                                        controller.passwordcontroller.text,context);
                                  }
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    controller.isloading3
                          ? const CommonLoading()
                          :  TextButton.icon(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Or continue with",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColor.secondcolor,
                              ),
                            ),
                            Image.asset(
                              AppImageAsset.google,
                              height: 50.0,
                            ),
                          ],
                        ),
                        onPressed: () {
                         controller.signInWithGoogle(context);
                        },
                      ),
                      const Spacer(),
                      CommonRowDown(
                        onTap: () => controller.gotosignup(context),
                        textrowone: "Don't have an account?  ",
                        textrowtwo: "Sign Up",
                      ),
                      const SizedBox(
                        height: 10.0,
                      )
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
