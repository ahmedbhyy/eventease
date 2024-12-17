import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/controller/profil/edit_profil_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/view/auth/authwidgets/button_auth.dart';
import 'package:eventease/view/auth/authwidgets/textfieldauth.dart';
import 'package:eventease/view/commonwidgets/commonloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../commonwidgets/common_appbar.dart';

class EditProfil extends StatelessWidget {
  const EditProfil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(EditProfilControllerImp());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "My Profil",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<EditProfilControllerImp>(
        builder: (controller) => Form(
          key: controller.formState,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              controller.isloading4
                  ? const Center(
                      child: SizedBox(
                        height: 160,
                        width: 100,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                        ),
                      ),
                    )
                  : Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 80.0,
                            backgroundImage: NetworkImage(controller.image),
                            backgroundColor: Colors.white,
                          ),
                          Positioned(
                            bottom: 10.0,
                            right: -5.0,
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(134, 158, 158, 158),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) =>
                                        controller.bottomSheet(
                                          context,
                                        )),
                                  );
                                },
                                icon: const Icon(Icons.camera_alt_outlined),
                                iconSize: 25.0,
                                color: AppColor.primarycolor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              const SizedBox(
                height: 20.0,
              ),
              controller.isloading2
                  ? const CommonLoading()
                  : Column(
                      children: [
                        ...List.generate(
                          controller.mylist.length,
                          (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFieldAuth(
                              hint: controller.mylist[index]["hint"],
                              mytype: TextInputType.text,
                              mysuffixicon: index == 2
                                  ? GestureDetector(
                                      onTap: () {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.question,
                                          animType: AnimType.rightSlide,
                                          title: "Adress",
                                          btnOkOnPress: () async {
                                            await controller.getcurrentadress();
                                          },
                                          desc:
                                              "You want to add your current location?",
                                        ).show();
                                      },
                                      child: controller.isloading3
                                          ? const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3.0,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.more_horiz,
                                              color: AppColor.secondcolor,
                                            ),
                                    )
                                  : null,
                              mycontroller: controller.mycontrollers[index],
                              myicon: controller.mylist[index]["myicon"],
                              ispass: false,
                              readonly: controller.mylist[index]["readonly"],
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          child: SizedBox(
                            height: 70.0,
                            child: IntlPhoneField(
                              controller: controller.phone,
                              dropdownIcon: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColor.secondcolor,
                              ),
                              style: const TextStyle(
                                color: AppColor.secondcolor,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                counterStyle: const TextStyle(
                                  color: AppColor.secondcolor,
                                ),
                                labelStyle: const TextStyle(
                                  color: AppColor.secondcolor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              initialCountryCode: 'TN',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Birthday date :",
                              style: GoogleFonts.mulish(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColor.secondcolor,
                              ),
                            ),
                            Container(
                              height: 100.0,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: AppColor.secondcolor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ScrollDatePicker(
                                selectedDate: controller.birthday.toDate(),
                                locale: const Locale('en'),
                                onDateTimeChanged: (DateTime value) {
                                  controller.birthday =
                                      Timestamp.fromDate(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        controller.isloading1
                            ? const CommonLoading()
                            : ButtonAuth(
                                mytitle: "Save",
                                myfunction: () {
                                  if (controller.formState.currentState!
                                      .validate()) {
                                    controller.saveUserData(context);
                                  }
                                },
                              ),
                        const SizedBox(height: 10.0),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
