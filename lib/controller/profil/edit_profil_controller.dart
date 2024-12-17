

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/view/commonwidgets/awesomedialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';

abstract class EditProfilController extends GetxController {
  saveUserData(BuildContext context);
  bottomSheet(BuildContext context);

  void getcurrentadress();

}

class EditProfilControllerImp extends EditProfilController {
  TextEditingController? username;
  TextEditingController? email;
  TextEditingController? phone;
  TextEditingController? location;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late User _user;
  String image = "https://cdn-icons-png.freepik.com/512/3001/3001764.png";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final ImagePicker _picker = ImagePicker();
  GlobalKey<FormState> formStateeditprofil = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloading1 = false;
  bool isloading2 = false;
  bool isloading3 = false;
  bool isloading4 = false;
  Timestamp birthday = Timestamp.now();

  List<TextEditingController> mycontrollers = [];

  List mylist = [
    {
      "hint": "Username",
      "myicon": const Icon(
        LineIcons.user,
        color: AppColor.secondcolor,
      ),
      "readonly": false,
    },
    {
      "hint": "Email",
      "myicon": const Icon(
        Icons.email_outlined,
        color: AppColor.secondcolor,
      ),
      "readonly": true,
    },
    {
      "hint": "Adress",
      "myicon": const Icon(
        Icons.location_on_outlined,
        color: AppColor.secondcolor,
      ),
      "readonly": false,
    },
  ];

  @override
  void dispose() {
    username!.dispose();
    email!.dispose();
    phone!.dispose();
    location!.dispose();
    super.dispose();
  }

  @override
  void onInit() async {
    _user = _auth.currentUser!;
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    location = TextEditingController();
    mycontrollers = [username!, email!, location!];
    email!.text = _user.email ?? "anonyme@gmail.com";
    await fetchUserData();
    super.onInit();
  }

  @override
  Widget bottomSheet(context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(
                  Icons.camera,
                  color: Color.fromARGB(255, 1, 128, 100),
                ),
                onPressed: () async {
                 
                },
                label: const Text("Camera"),
              ),
              TextButton.icon(
                icon: const Icon(
                  Icons.image,
                  color: Color.fromARGB(255, 1, 128, 100),
                ),
                onPressed: () async {
                
                },
                label: const Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

 

  @override
  Future saveUserData(BuildContext context) async {
    try {
      isloading1 = true;
      update();
      String nomuser = username!.text;
      String number = phone!.text;
      String adress = location!.text;
      Timestamp birthdaydate = birthday;

      await _firestore.collection('users').doc(_user.uid).set({
        'name': nomuser,
        'phone': number,
        'birthdaydate': birthdaydate,
        'adress': adress,
      }, SetOptions(merge: true));
      isloading1 = false;
      // ignore: use_build_context_synchronously
      showAwesomeDialog(context, "Success",
          "Your information has been saved successfully", DialogType.success);

      update();
    } catch (e) {
      // ignore: use_build_context_synchronously
      return showAwesomeDialog(
          // ignore: use_build_context_synchronously
          context,
          "Error",
          "Please try again",
          DialogType.error);
    }
  }

  Future fetchUserData() async {
    try {
      isloading2 = true;
      update();
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(_user.uid).get();
      var userData = docSnapshot.data();
      isloading2 = false;
      update();
      if (docSnapshot.exists) {
        if (userData is Map<String, dynamic>) {
          username!.text = userData['name'] ?? "";
          phone!.text = userData['phone'] ?? "";
          location!.text = userData['adress'] ?? "";
          birthday = userData['birthdaydate'] ?? DateTime.timestamp();
        }
      } else {
        return Get.rawSnackbar(
            title: "Note",
            message: "Please write your informations",
            backgroundColor: Colors.green);
      }
    } catch (e) {
      return Get.rawSnackbar(
          title: "Note",
          message: "Please write your informations",
          backgroundColor: Colors.green);
    }
  }

  @override
  Future<void> getcurrentadress() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }
      isloading3 = true;
      update();
      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = "${place.street}, ${place.locality}, ${place.country}";
        location!.text = address;
      }
      isloading3 = false;
      update();
    } catch (e) {
      isloading3 = false;
      update();
      Get.rawSnackbar(title: "Error", message: "please try again");
    }
  }

  
}
