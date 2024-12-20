import 'package:eventease/core/constant/color.dart';
import 'package:eventease/data/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class OrderDetailsController extends GetxController {}

class OrderDetailsControllerImp extends OrderDetailsController {
  openbootom(OrderModel myorder) {
    Get.bottomSheet(
      backgroundColor: AppColor.secondcolor,
      ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order : ${myorder.orderdate.toString().substring(0, 10)}",
                style: GoogleFonts.mulish(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primarycolor,
                ),
              ),
              const Text(
                "En Cours",
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Phone number:",
                style: GoogleFonts.mulish(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primarycolor,
                ),
              ),
              Text(
                "+216 ${myorder.phone}",
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "items:",
                style: GoogleFonts.mulish(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primarycolor,
                ),
              ),
              CircleAvatar(
                radius: 12.0,
                backgroundColor: AppColor.redcolor,
                child: Text(
                  "${myorder.productlist.length}",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          ...List.generate(
            myorder.productlist.length,
            (index) {
              final product = myorder.productlist.entries.toList()[index];
              return Row(
                children: [
                  Text(product.key),
                  const SizedBox(width: 8),
                  Text(product.value.toString()),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
