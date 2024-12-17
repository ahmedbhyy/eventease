import 'package:eventease/controller/home/home_controller.dart';

import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';

import 'package:eventease/view/commonwidgets/cached_image.dart';
import 'package:eventease/view/home/homewidget/container_categories.dart';
import 'package:eventease/view/home/notifications.dart';
import 'package:eventease/view/home/productsscreens/product_details.dart';
import 'package:eventease/view/home/product_search.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: GetBuilder<HomeControllerImp>(
          builder: (controller) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover products",
                    style: GoogleFonts.mulish(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondcolor,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            SlideRight(
                              page: NotificationsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          LineIcons.bell,
                          color: AppColor.secondcolor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            SlideRight(
                              page: SearchPage(
                                myproducts: controller.allProducts,
                                categories: controller.categories,
                                userId: controller.userId!,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          LineIcons.search,
                          color: AppColor.secondcolor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      controller.categories.length,
                      (index) => InkWell(
                        onTap: () {
                          controller.selectedcategorie =
                              controller.categories[index].name;
                          controller.update();
                        },
                        child: ContainerCategories(
                          title: controller.categories[index].name,
                          image: controller.categories[index].image,
                          isselected: controller.selectedcategorie ==
                              controller.categories[index].name,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${controller.changecategorie(controller.selectedcategorie).products.length.toString()} Items",
                    style: GoogleFonts.mulish(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondcolor,
                    ),
                  ),
                  DropdownButton<String>(
                    value: controller.dropdownvalue,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    elevation: 16,
                    underline: Container(
                      color: AppColor.primarycolor,
                    ),
                    style: const TextStyle(color: Color(0xfff2c5a2)),
                    onChanged: (String? value) {
                      controller.dropdownvalue = value!;
                      controller.update();
                    },
                    dropdownColor: AppColor.redcolor,
                    items: controller.list
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getAllProducts();
                  },
                  child: ListView(
                    children: [
                      controller.isloading
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 50.0),
                              child: Lottie.asset(
                                AppImageAsset.loading,
                                height: 150,
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: 0.6,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller
                                  .changecategorie(controller.selectedcategorie)
                                  .products
                                  .length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    SlideRight(
                                      page: ProductDetails(
                                        mycategory: controller
                                            .getCategoryForProduct(controller
                                                .changecategorie(controller
                                                    .selectedcategorie)
                                                .products[index]),
                                        myproduct: controller
                                            .changecategorie(
                                                controller.selectedcategorie)
                                            .products[index],
                                        isfavorite: controller.isFavorite(
                                            controller
                                                .changecategorie(controller
                                                    .selectedcategorie)
                                                .products[index]),
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xff2d3b4b),
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          CachedImageWidget(
                                            image: controller
                                                .changecategorie(controller
                                                    .selectedcategorie)
                                                .products[index]
                                                .image,
                                            borderradius: 15,
                                            height: 160.0,
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            controller
                                                .changecategorie(controller
                                                    .selectedcategorie)
                                                .products[index]
                                                .name,
                                            style: GoogleFonts.mulish(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.secondcolor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            controller
                                                .getCategoryForProduct(controller
                                                    .changecategorie(controller
                                                        .selectedcategorie)
                                                    .products[index])
                                                .name,
                                            style: GoogleFonts.mulish(
                                              fontSize: 16.0,
                                              color: AppColor.greycolor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              controller
                                                          .changecategorie(
                                                              controller
                                                                  .selectedcategorie)
                                                          .products[index]
                                                          .remise !=
                                                      0.0
                                                  ? Text(
                                                      "${controller.changecategorie(controller.selectedcategorie).products[index].remise + controller.changecategorie(controller.selectedcategorie).products[index].prix} TND",
                                                      style: GoogleFonts.mulish(
                                                        fontSize: 14.0,
                                                        decorationColor:
                                                            AppColor
                                                                .secondcolor,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: const Color(
                                                            0xfff2c5a2),
                                                      ),
                                                    )
                                                  : Container(),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                "${controller.changecategorie(controller.selectedcategorie).products[index].prix} TND",
                                                style: GoogleFonts.mulish(
                                                  fontSize: 14.0,
                                                  color:
                                                      const Color(0xfff2c5a2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColor.primarycolor,
                                          child: IconButton(
                                            onPressed: () {
                                              controller.toggleFavorite(
                                                  controller
                                                      .changecategorie(controller
                                                          .selectedcategorie)
                                                      .products[index]);
                                            },
                                            icon: controller.isFavorite(controller
                                                    .changecategorie(controller
                                                        .selectedcategorie)
                                                    .products[index])
                                                ? const Icon(
                                                    LineIcons.heartAlt,
                                                    color: AppColor.redcolor,
                                                  )
                                                : const Icon(
                                                    LineIcons.heart,
                                                    color: AppColor.redcolor,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 70.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
