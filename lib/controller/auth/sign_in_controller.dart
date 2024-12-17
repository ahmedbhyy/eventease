import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventease/view/auth/sign_up.dart';
import 'package:eventease/view/commonwidgets/awesomedialog.dart';
import 'package:eventease/view/home/start_screen.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignInController extends GetxController {
  hidepaasword();
  gotosignup(BuildContext context);
  signin(String email, String password, BuildContext context);
  forgetpassword(String email, BuildContext context);
  signInWithGoogle(BuildContext context);
}

class SignInControllerImp extends SignInController {
  bool ispasswordhidden = true;
  bool isloading1 = false;
  bool isloading2 = false;
  bool isloading3 = false;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formStateSignIn = GlobalKey<FormState>();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // final LocalAuthentication auth = LocalAuthentication();
  bool supportstate = false;

  @override
  hidepaasword() {
    ispasswordhidden = !ispasswordhidden;
    update();
  }

  @override
  gotosignup(BuildContext context) {
    Navigator.of(context).pushReplacement(
      SlideRight(
        page: const SignUp(),
      ),
    );
  }

  @override
  void onInit() async {
    await secureStorage.write(
      key: "onboardingvisited",
      value: "1",
    );
    super.onInit();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  signin(String email, String password, BuildContext context) async {
    try {
      isloading1 = true;
      update();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      isloading1 = false;
      update();
      if (credential.user!.emailVerified) {
        Get.offAll(() => const StartPage());
        emailcontroller.clear();
        passwordcontroller.clear();
      } else {
        showAwesomeDialog(
            // ignore: use_build_context_synchronously
            context,
            "Verify Your Account",
            "An email was send to you. Please verify your Account",
            DialogType.error);
      }
    } on FirebaseAuthException catch (e) {
      isloading1 = false;
      update();
      if (e.code == 'user-not-found') {
        return Get.rawSnackbar(
            title: "user-not-found",
            message: "No user found for that email. Please Sign up",
            backgroundColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        return Get.rawSnackbar(
            title: "Wrong password",
            message: "Wrong password provided for that user.",
            backgroundColor: Colors.red);
      } else {
        return Get.rawSnackbar(
            title: "Error",
            message: "Please try again",
            backgroundColor: Colors.red);
      }
    }
  }

  @override
  forgetpassword(String email, context) async {
    try {
      isloading2 = true;
      update();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      isloading2 = false;
      update();
      // ignore: use_build_context_synchronously
      showAwesomeDialog(
          // ignore: use_build_context_synchronously
          context,
          "Reset Password",
          "An email was sent to you. Please reset your password!",
          DialogType.success);
    } catch (e) {
      isloading2 = false;
      update();
      return Get.rawSnackbar(
          title: "Error",
          message: "Email not found. Please try again",
          backgroundColor: Colors.red);
    }
  }

  @override
  Future signInWithGoogle(context) async {
    try {
      isloading3 = true;
      update();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      isloading3 = false;
      update();
      if (googleUser == null) {
        return Get.rawSnackbar(
            title: "Google Sign in", message: "no account selected");
      } else {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.offAll(() => const StartPage());
      }
    } catch (e) {
      isloading3 = false;
      update();
      return Get.rawSnackbar(title: "Error", message: "Please try again");
    }
  }
}
