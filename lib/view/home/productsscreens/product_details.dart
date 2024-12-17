import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventease/controller/home/product_details_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/data/model/category_model.dart';
import 'package:eventease/data/model/product_model.dart';
import 'package:eventease/view/commonwidgets/cached_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  final ProductModel myproduct;
  final CategoryModel mycategory;
  bool isfavorite;
  ProductDetails(
      {super.key,
      required this.myproduct,
      required this.mycategory,
      required this.isfavorite});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsControllerImp());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              myproduct.image,
            ),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
        ),
        child: SafeArea(
          child: GetBuilder<ProductDetailsControllerImp>(
            builder: (controller) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40.0,
                        decoration: const BoxDecoration(
                          color: AppColor.primarycolor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                          ),
                          iconSize: 20.0,
                          color: AppColor.secondcolor,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: AppColor.primarycolor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                CachedImageWidget(
                                  image: mycategory.image,
                                  borderradius: 15,
                                  height: 35.0,
                                  width: 35.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "In collection",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.greycolor,
                                      ),
                                    ),
                                    Text(
                                      mycategory.name,
                                      style: GoogleFonts.mulish(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.secondcolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 40.0,
                            decoration: const BoxDecoration(
                              color: AppColor.primarycolor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                controller.toggleFavorite(
                                    myproduct, isfavorite);
                                isfavorite = !isfavorite;
                              },
                              icon: isfavorite
                                  ? const Icon(
                                      LineIcons.heartAlt,
                                    )
                                  : const Icon(
                                      LineIcons.heart,
                                    ),
                              iconSize: 20.0,
                              color: AppColor.redcolor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    decoration: const BoxDecoration(
                      color: AppColor.primarycolor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                    ),
                    height: MediaQuery.of(context).size.height / 2.8,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myproduct.name,
                              style: GoogleFonts.mulish(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xfff6c9a4),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1d4c36),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.percent,
                                        size: 15.0,
                                        color: Color(0xfff6c9a4),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "on sale",
                                        style: TextStyle(
                                          color: Color(0xfff6c9a4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                const Icon(
                                  LineIcons.starAlt,
                                  color: AppColor.redcolor,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                const Text(
                                  "4.8",
                                  style: TextStyle(
                                    color: AppColor.secondcolor,
                                    fontSize: 15.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                const Icon(
                                  Icons.chat_outlined,
                                  color: Color.fromARGB(198, 255, 255, 255),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                const Text(
                                  "9 reviews",
                                  style: TextStyle(
                                    color: AppColor.secondcolor,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Text(
                              "ezrtrazegerh",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: GoogleFonts.mulish(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: AppColor.secondcolor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Color.fromARGB(168, 172, 161, 161),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    myproduct.remise != 0
                                        ? Text(
                                            "${myproduct.remise.toString()} TND",
                                            style: GoogleFonts.mulish(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: AppColor.greycolor,
                                            ),
                                          )
                                        : Container(),
                                    Text(
                                      "${myproduct.prix.toString()} TND",
                                      style: GoogleFonts.mulish(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.secondcolor,
                                      ),
                                    ),
                                  ],
                                ),
                                controller.isloading
                                    ? Lottie.asset(
                                        AppImageAsset.loading,
                                        height: 50,
                                      )
                                    : MaterialButton(
                                        padding: const EdgeInsets.all(8),
                                        color: AppColor.redcolor,
                                        onPressed: () {
                                          controller.productsid
                                                  .contains(myproduct.id)
                                              ? controller
                                                  .removeFromCart(myproduct.id)
                                              : controller.addToCart(myproduct);
                                        },
                                        minWidth: 200.0,
                                        elevation: 6,
                                        shape: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(67, 0, 0, 0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          controller.productsid
                                                  .contains(myproduct.id)
                                              ? "Remove from cart"
                                              : "Add to Cart",
                                          style: GoogleFonts.mulish(
                                            fontSize: 18,
                                            color: AppColor.secondcolor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
