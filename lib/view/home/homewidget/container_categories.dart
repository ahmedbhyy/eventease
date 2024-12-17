import 'package:eventease/core/constant/color.dart';
import 'package:eventease/view/commonwidgets/cached_image.dart';
import 'package:flutter/material.dart';

class ContainerCategories extends StatelessWidget {
  final String title;
  final String image;
  final bool isselected;
  const ContainerCategories(
      {super.key,
      required this.title,
      required this.image,
      required this.isselected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 5.0,
      ),
      decoration: BoxDecoration(
        color: isselected ? Colors.white : const Color(0xff2f3d4e),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          CachedImageWidget(
            image: image,
            borderradius: 20,
            width: 35.0,
            height: 30.0,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.0,
              color: isselected ? AppColor.primarycolor : AppColor.secondcolor,
            ),
          )
        ],
      ),
    );
  }
}
