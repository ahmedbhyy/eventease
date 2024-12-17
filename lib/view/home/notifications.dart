import 'package:eventease/controller/home/notifications_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/view/commonwidgets/cached_image.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class NotificationsScreen extends StatelessWidget {
  final List<String> items =
      List.generate(3, (index) => 'Notification ${index + 1}');
  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsControllerImp());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Notifications",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<NotificationsControllerImp>(
        builder: (controller) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      controller.updatecolor();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      padding: const EdgeInsets.all(5.0),
                      width: controller.isselected ? 100.0 : 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: controller.isselected
                            ? AppColor.redcolor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        "New",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: !controller.isselected
                              ? AppColor.redcolor
                              : const Color.fromARGB(206, 255, 255, 255),
                          fontWeight: controller.isselected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      controller.updatecolor();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      padding: const EdgeInsets.all(5.0),
                      width: !controller.isselected ? 100.0 : 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: !controller.isselected
                            ? AppColor.redcolor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        "All",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: controller.isselected
                              ? AppColor.redcolor
                              : const Color.fromARGB(206, 255, 255, 255),
                          fontWeight: !controller.isselected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  //print("eazea");
                  return;
                },
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  children: [
                    Text(
                      controller.isselected ? "New" : "All",
                      style: GoogleFonts.mulish(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondcolor),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ...items.map(
                      (item) => Dismissible(
                        key: Key(item),
                        background: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.red, Colors.redAccent],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  LineIcons.alternateTrash,
                                  color: Colors.white,
                                  size: 26.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          items.remove(item);
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                item,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              subtitle: const Text(
                                "New Product is available",
                                style: TextStyle(color: Colors.grey),
                              ),
                              trailing: const Text(
                                "ilya 30min",
                                style: TextStyle(color: Colors.grey),
                              ),
                              leading: const CachedImageWidget(
                                borderradius: 20.0,
                                width: 40.0,
                                image:
                                    "https://cdn-icons-png.flaticon.com/512/4226/4226663.png",
                              ),
                            ),
                            const Divider(
                              height: 5.0,
                              indent: 10,
                              endIndent: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
