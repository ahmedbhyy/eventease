import 'package:eventease/controller/home/start_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StartControllerImp());
    return GetBuilder<StartControllerImp>(
      builder: (controller) => Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColor.redcolor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
              child: GNav(
                gap: 8,
                backgroundColor: AppColor.redcolor,
                activeColor: AppColor.secondcolor,
                iconSize: 25,
                textStyle: GoogleFonts.mulish(
                  fontSize: 14.0,
                  color: AppColor.secondcolor,
                  fontWeight: FontWeight.bold,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColor.primarycolor,
                tabs: [
                  const GButton(
                    icon: LineIcons.home,
                    iconColor: AppColor.secondcolor,
                    text: 'Home',
                  ),
                  const GButton(
                    icon: LineIcons.heart,
                    iconColor: AppColor.secondcolor,
                    text: 'Favorites',
                  ),
                  GButton(
                    icon: LineIcons.shoppingCart,
                    iconColor: AppColor.secondcolor,
                    text: 'Cart',
                    leading: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(
                          LineIcons.shoppingCart,
                          color: AppColor.secondcolor,
                        ),
                        if (controller.cartItems.isNotEmpty)
                          Positioned(
                            top: -5,
                            right: -5,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColor.primarycolor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${controller.cartItems.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                   GButton(
                    icon: LineIcons.user,
                    iconColor: AppColor.secondcolor,
                    text: "1".tr,
                  ),
                ],
                selectedIndex: controller.selectedIndex,
                onTabChange: (index) {
                  controller.generatewindow(index);
                },
              ),
            ),
          ),
        ),
        body: controller.listPage.elementAt(controller.selectedIndex),
      ),
    );
  }
}
