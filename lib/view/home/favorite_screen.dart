import 'package:eventease/controller/home/favorite_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/commonwidgets/cached_image.dart';
// import 'package:eventease/view/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesControllerImp());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: GetBuilder<FavoritesControllerImp>(
          builder: (controller) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Favorites",
                    style: GoogleFonts.mulish(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondcolor,
                    ),
                  ),
                  const Icon(
                    LineIcons.heartAlt,
                    color: AppColor.redcolor,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: controller.filterProducts,
                  decoration: InputDecoration(
                    hintText: 'Search for products',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.searchController.clear();
                        controller.filterProducts('');
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
              controller.isloading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Lottie.asset(
                        AppImageAsset.loading,
                        height: 150,
                      ),
                    )
                  : controller.filteredProducts.isEmpty
                      ?
                      // ? Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 50.0),
                      //     child: Lottie.asset(
                      //       AppImageAsset.empty,
                      //       repeat: false,
                      //       height: 150,
                      //     ),
                      //   )
                      Center(
                          child: Column(
                            children: [
                              Lottie.asset(
                                AppImageAsset.empty,
                                repeat: false,
                                height: 120,
                              ),
                              Text(
                                'No favorites',
                                style: GoogleFonts.mulish(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.secondcolor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20.0,
                            childAspectRatio: 0.75,
                          ),
                          shrinkWrap: true,
                          itemCount: controller.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = controller.filteredProducts[index];
                            return InkWell(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   SlideRight(
                                //     page: ProductDetails(
                                //       mycategory: controller.getCategoryForProduct(
                                //           controller
                                //               .changecategorie(
                                //                   controller.selectedcategorie)
                                //               .products[index]),
                                //       myproduct: controller
                                //           .changecategorie(
                                //               controller.selectedcategorie)
                                //           .products[index],
                                //       isfavorite: controller.isFavorite(controller
                                //           .changecategorie(
                                //               controller.selectedcategorie)
                                //           .products[index]),
                                //     ),
                                //   ),
                                // );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xff2d3b4b),
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    CachedImageWidget(
                                      image: product.image,
                                      borderradius: 15,
                                      height: 160.0,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      product.name,
                                      style: GoogleFonts.mulish(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.secondcolor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        product.remise != 0.0
                                            ? Text(
                                                "${product.remise} TD",
                                                style: GoogleFonts.mulish(
                                                  fontSize: 14.0,
                                                  decorationColor:
                                                      AppColor.secondcolor,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color:
                                                      const Color(0xfff2c5a2),
                                                ),
                                              )
                                            : Container(),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          "${product.prix} TD",
                                          style: GoogleFonts.mulish(
                                            fontSize: 14.0,
                                            color: const Color(0xfff2c5a2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
