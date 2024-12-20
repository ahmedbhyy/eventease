import 'package:eventease/controller/home/order_details_controller.dart';
import 'package:eventease/core/constant/color.dart';

import 'package:eventease/data/model/order_model.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';

import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatelessWidget {
  final OrderModel myorder;
  const OrderDetails({super.key, required this.myorder});

  @override
  Widget build(BuildContext context) {
    OrderDetailsControllerImp mycontroller =
        Get.put(OrderDetailsControllerImp());
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primarycolor,
        onPressed: () {
          mycontroller.openbootom(myorder);
        },
        child: const Icon(
          Icons.info_outline,
          color: AppColor.secondcolor,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "My Order",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<OrderDetailsControllerImp>(
        builder: (controller) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(36.89203, 10.18800),
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                const MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(36.89203, 10.18800),
                      width: 80.0,
                      height: 80.0,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
