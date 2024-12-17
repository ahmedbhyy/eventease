import 'package:eventease/controller/settings/language_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/local/local_controller.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controllerlang = Get.find();
    Get.put(LanguageControllerImp());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Language",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<LanguageControllerImp>(
        builder: (controller) => ListView(
          padding: const EdgeInsets.all(10),
          children: [
             Image.asset(AppImageAsset.language),
            ...List.generate(
              controller.languages.length,
              (index) => SizedBox(
                height: 70.0,
                child: Card(
                  elevation: 5.0,
                  color: Colors.white,
                  margin: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        controller.updateColor(index);
                        controllerlang
                            .changelang(controller.languagesid[index]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.languages[index],
                            style: TextStyle(
                              fontSize: 17.0,
                              color: controller.isSelectedList[index]
                                  ? const Color.fromARGB(255, 1, 42, 43)
                                  : const Color.fromARGB(255, 99, 150, 151),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AnimatedContainer(
                            width: 20.0,
                            decoration: BoxDecoration(
                              color: controller.isSelectedList[index]
                                  ? AppColor.redcolor
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            duration: const Duration(milliseconds: 300),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
