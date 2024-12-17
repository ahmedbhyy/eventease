import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/data/model/category_model.dart';
import 'package:eventease/data/model/product_model.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:eventease/view/home/productsscreens/product_details.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  final List<ProductModel> myproducts;
  final List<CategoryModel> categories;
  final String userId;

  const SearchPage(
      {super.key,
      required this.myproducts,
      required this.categories,
      required this.userId});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> favoritesproducts = [];
  FocusNode focusNode = FocusNode();

  Future<void> loadFavorites() async {
    try {
      final favoritesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('favoriteProducts')
          .get();

      favoritesproducts = favoritesSnapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
      setState(() {});
    } catch (e) {
       Get.rawSnackbar(
          title: "Error",
          message: "Failed to load favorites",
          backgroundColor: AppColor.redcolor);
    }
  }

  @override
  void initState() {
    loadFavorites();
    super.initState();
    _filteredProducts = widget.myproducts;
    Future.delayed(Duration.zero, () {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  CategoryModel getCategoryForProduct(ProductModel product) {
    return widget.categories.firstWhere(
      (category) =>
          category.products.contains(product) && category.name != "All",
      orElse: () => CategoryModel(name: 'Unknown', image: '', products: []),
    );
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = widget.myproducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Search",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: _filterProducts,
              focusNode: focusNode,
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
                      searchController.clear();
                      _filterProducts('');
                    },
                    icon: const Icon(Icons.close),
                  )),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _filteredProducts.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(207, 196, 184, 184),
                            backgroundImage: NetworkImage(product.image),
                          ),
                          title: Text(
                            product.name,
                            style: GoogleFonts.mulish(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondcolor,
                            ),
                          ),
                          subtitle: Text(
                            'Price: ${product.prix} TND',
                            style: GoogleFonts.mulish(
                              fontSize: 13.0,
                              color: AppColor.greycolor,
                            ),
                          ),
                          trailing: Text(
                            getCategoryForProduct(product).name,
                            style: GoogleFonts.mulish(
                              fontSize: 13.0,
                              color: AppColor.secondcolor,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              SlideRight(
                                page: ProductDetails(
                                  myproduct: product,
                                  isfavorite: favoritesproducts
                                      .any((fav) => fav.id == product.id),
                                  mycategory: getCategoryForProduct(product),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Center(
                      child: Lottie.asset(
                        AppImageAsset.empty,
                        height: 200.0,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
