import 'package:eventease/core/constant/imageasset.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class ContactController extends GetxController {
  launchurl(url);
  callphone(String phone);
  sendemail(String email);
}

class ContactControllerImp extends ContactController {
  List<String> contactimages = [
    AppImageAsset.phone,
    AppImageAsset.facebook,
    AppImageAsset.insta,
    AppImageAsset.mail,
  ];
  List<String> urls = [
    "58435557",
    "https://www.facebook.com/ahmed.belhajyahia/",
    "https://www.instagram.com/ahmedbelhajyahia/",
    "ahmed.belhajyahia@supcom.tn",
  ];

  @override
  launchurl(url) async {
    if (!await launchUrl(url)) {
      Get.snackbar("Error", "Please try again later !");
    }
  }

  @override
  callphone(String phone) async {
    if (!await launchUrlString("tel://$phone")) {
      Get.snackbar("Error", "Please try again later !");
    }
  }

  @override
  sendemail(String email) async {
    if (!await launchUrlString("mailto:$email")) {
      Get.snackbar("Error", "Please try again later !");
    }
  }
}
