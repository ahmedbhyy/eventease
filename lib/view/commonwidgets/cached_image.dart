import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final double borderradius;
  const CachedImageWidget(
      {super.key,
      required this.image,
      this.height,
      this.width,
      required this.borderradius});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(borderradius),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 222, 217, 217),
          highlightColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderradius),
              color: const Color.fromARGB(255, 201, 198, 198),
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
