import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventease/view/commonwidgets/awesomedialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ChangePasswordController extends GetxController {
  void changepassword(BuildContext context);
}

class ChangePasswordControllerImp extends ChangePasswordController {
  TextEditingController? oldpassword;
  TextEditingController? newpassword;
  TextEditingController? confirmnewpassword;
  GlobalKey<FormState> formStatechangepassword = GlobalKey<FormState>();
  @override
  void onInit() {
    oldpassword = TextEditingController();
    newpassword = TextEditingController();
    confirmnewpassword = TextEditingController();
    super.onInit();
  }

  @override
  void changepassword(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    if (googleSignIn.clientId == null) {
      Get.rawSnackbar(
        title: 'Error',
        message:
            'You can\'t modify your password because you are signed in with Google!',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (newpassword!.text == confirmnewpassword!.text &&
        newpassword!.text.length >= 8) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updatePassword(newpassword!.text);
          oldpassword!.clear();
          newpassword!.clear();
          confirmnewpassword!.clear();
          showAwesomeDialog(
            // ignore: use_build_context_synchronously
            context,
            "Success",
            "You have changed your password",
            DialogType.success,
          );
        } else {
          Get.rawSnackbar(
            title: 'Error',
            message: 'No user is currently signed in!',
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        Get.rawSnackbar(
          title: 'Error',
          message: 'Please try again',
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.rawSnackbar(
        title: 'Error',
        message: 'Passwords not match',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void dispose() {
    oldpassword!.dispose();
    newpassword!.dispose();
    confirmnewpassword!.dispose();
    super.dispose();
  }
}
