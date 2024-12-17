import 'package:eventease/core/constant/imageasset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Lottie.asset(AppImageAsset.loading, height: 80.0),
    );
  }
}
