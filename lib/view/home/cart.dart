import 'package:eventease/controller/home/cart_controller.dart';

import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/auth/authwidgets/button_auth.dart';
import 'package:eventease/view/commonwidgets/cached_image.dart';
import 'package:eventease/view/home/checkout.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartControllerImp());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: cartController.cartStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cart",
                          style: GoogleFonts.mulish(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondcolor,
                          ),
                        ),
                        const Icon(
                          LineIcons.shoppingCart,
                          color: AppColor.redcolor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Lottie.asset(
                        AppImageAsset.loading,
                        height: 150,
                      ),
                    ),
                  ],
                );
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cart",
                          style: GoogleFonts.mulish(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondcolor,
                          ),
                        ),
                        const Icon(
                          LineIcons.shoppingCart,
                          color: AppColor.redcolor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                        child: Text(
                      'Error: ${snapshot.error}',
                      style: GoogleFonts.mulish(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColor.secondcolor,
                      ),
                    )),
                  ],
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cart",
                          style: GoogleFonts.mulish(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondcolor,
                          ),
                        ),
                        const Icon(
                          LineIcons.shoppingCart,
                          color: AppColor.redcolor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                            AppImageAsset.empty,
                            repeat: false,
                            height: 120,
                          ),
                          Text(
                            'Your cart is empty.',
                            style: GoogleFonts.mulish(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              final cartItems = snapshot.data!;
              cartController.cartItems.value = cartItems;

              double total = cartController.calculateTotal();
              return Builder(builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cart",
                            style: GoogleFonts.mulish(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondcolor,
                            ),
                          ),
                          const Icon(
                            LineIcons.shoppingCart,
                            color: AppColor.redcolor,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.9,
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: CachedImageWidget(
                                    image: item['image'],
                                    borderradius: 8,
                                    height: 70.0,
                                    width: 60.0,
                                  ),
                                  title: Text(
                                    item['name'],
                                    style: GoogleFonts.mulish(
                                      fontSize: 16,
                                      color: AppColor.secondcolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: item["remise"] + 0.0 != 0.0
                                      ? Text(
                                          "${item['prix'] * (1 - item["remise"] / 100)} DT",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColor.greycolor,
                                          ),
                                        )
                                      : Text(
                                          "${item["prix"]} DT",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColor.greycolor,
                                          ),
                                        ),
                                  trailing: SizedBox(
                                    width: 115,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                          color: AppColor.redcolor,
                                          iconSize: 22.0,
                                          onPressed: () {
                                            cartController.updatequantity(
                                              item["id"],
                                              item['quantity'] - 1,
                                            );
                                            if (item["quantity"] <= 1) {
                                              cartController.removefromcart(
                                                item["id"],
                                              );
                                            }
                                          },
                                        ),
                                        Text(
                                          "${item['quantity']}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color: AppColor.secondcolor,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_circle_rounded,
                                          ),
                                          color: AppColor.secondcolor,
                                          iconSize: 22.0,
                                          onPressed: () {
                                            cartController.updatequantity(
                                              item["id"],
                                              item['quantity'] + 1,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 0.5,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      GetBuilder<CartControllerImp>(
                        builder: (controller) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal :",
                                    style: GoogleFonts.mulish(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 172, 161, 161),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.couponremise != 0.0
                                        ? "${total * (1 - controller.couponremise / 100)} DT"
                                        : "${total.toString()} DT",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.secondcolor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              controller.isloading
                                  ? Lottie.asset(
                                      AppImageAsset.loading,
                                      height: 50,
                                    )
                                  : controller.couponexist
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Coupon :",
                                              style: GoogleFonts.mulish(
                                                fontSize: 16,
                                                color: const Color.fromARGB(
                                                    255, 172, 161, 161),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {
                                                controller.couponexist = false;
                                                controller.couponremise = 0.0;
                                                controller.update();
                                              },
                                              iconAlignment: IconAlignment.end,
                                              label: Text(
                                                controller.couponname,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.redcolor,
                                                ),
                                              ),
                                              icon: const Icon(
                                                Icons.remove_circle,
                                                size: 18.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      : TextField(
                                          controller:
                                              controller.couponController,
                                          style: const TextStyle(
                                              color: AppColor.secondcolor),
                                          decoration: InputDecoration(
                                            labelText: 'Enter coupon code',
                                            labelStyle: const TextStyle(
                                              color: AppColor.greycolor,
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () async {
                                                if (controller
                                                    .couponname.isNotEmpty) {
                                                  await controller
                                                      .checkCouponExists(
                                                          controller
                                                              .couponname);
                                                } else {
                                                  Get.snackbar('Error',
                                                      'Please enter a coupon code.',
                                                      backgroundColor:
                                                          Colors.red,
                                                      colorText: Colors.white);
                                                }
                                                controller.couponController
                                                    .clear();
                                              },
                                              icon: const Icon(
                                                Icons.search,
                                                color: AppColor.redcolor,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            controller.couponname = value;
                                          },
                                        ),
                              const SizedBox(
                                height: 25,
                              ),
                              ButtonAuth(
                                mytitle: "Check out",
                                myfunction: () {
                                  Navigator.of(context).push(
                                    SlideRight(
                                      page: CheckOut(
                                        total: total,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
            }),
      ),
    );
  }
}
