import 'package:eventease/controller/profil/settingscontroller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:eventease/view/commonwidgets/commonrowprofil.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsControllerImp controller = Get.put(SettingsControllerImp());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Settings",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Image.asset(
            AppImageAsset.settings,
            height: 200.0,
          ),
          ...List.generate(
            controller.options.length,
            (index) => InkWell(
              onTap: () {
                Navigator.of(context).push(
                  SlideRight(page: controller.categoriespages[index]),
                );
              },
              child: CommonRowProfil(
                title: controller.options[index]["title"],
                myicon: controller.options[index]["icon"],
                description: controller.options[index]["description"],
              ),
            ),
          ),
          GetBuilder<SettingsControllerImp>(
            builder: (controller) => CommonRowProfil(
              title: "Notifications",
              myicon: controller.notificationactive
                  ? const Icon(Icons.notifications_active_outlined)
                  : const Icon(Icons.notifications_off_outlined),
              description:
                  controller.notificationactive ? "Active" : "Inactive",
              switche: Switch(
                value: controller.notificationactive,
                activeColor: AppColor.redcolor,
                onChanged: (bool value) async {
                  controller.notificationactive = value;
                  await secureStorage!.write(
                    key: "notifications",
                    value: value == true ? "1" : "0",
                  );
                  controller.update();
                  value
                      ? FirebaseMessaging.instance.subscribeToTopic('eventease')
                      : FirebaseMessaging.instance
                          .unsubscribeFromTopic('eventease');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
