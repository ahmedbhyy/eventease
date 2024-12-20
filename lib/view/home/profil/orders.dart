import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:eventease/controller/profil/orders_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:eventease/view/commonwidgets/commonloading.dart';
import 'package:eventease/view/home/profil/order_details.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constant/imageasset.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersControllerImp mycontroller = Get.put(OrdersControllerImp());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "My Orders",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              mycontroller.updaetdate(selectedDate);
            },
            activeColor: AppColor.redcolor,
            locale: "FR",
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              selectedDateStyle: TextStyle(
                color: AppColor.secondcolor,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
              monthStyle: TextStyle(
                color: AppColor.secondcolor,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
              dateFormatter: DateFormatter.fullDateDayAsStrMY(),
            ),
            dayProps: const EasyDayProps(
              activeDayStyle: DayStyle(
                borderRadius: 32.0,
              ),
              inactiveDayStyle: DayStyle(
                borderRadius: 32.0,
                dayNumStyle: TextStyle(color: AppColor.secondcolor),
              ),
            ),
            timeLineProps: const EasyTimeLineProps(
              hPadding: 16.0,
              separatorPadding: 16.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          GetBuilder<OrdersControllerImp>(
            builder: (controller) => Expanded(
              child: controller.isloading
                  ? const CommonLoading()
                  : controller.ordersperday(controller.selectedday).isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              Lottie.asset(
                                AppImageAsset.empty,
                                repeat: false,
                                height: 120,
                              ),
                              Text(
                                'No orders!',
                                style: GoogleFonts.mulish(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.secondcolor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await controller.fetchorders();
                          },
                          child: ListView(
                            children: [
                              ...List.generate(
                                controller
                                    .ordersperday(controller.selectedday)
                                    .length,
                                (index) {
                                  final order = controller.ordersperday(
                                      controller.selectedday)[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                          "Order ${index + 1}",
                                          style: GoogleFonts.mulish(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                            "${order.total} TND | ${order.status}"),
                                        leading: Image.asset(
                                          AppImageAsset.order,
                                          width: 60.0,
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            SlideRight(
                                              page: OrderDetails(
                                                myorder: order,
                                              ),
                                            ),
                                          );
                                        },
                                        trailing: const Icon(
                                          LineIcons.arrowCircleRight,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
            ),
          )
        ],
      ),
    );
  }
}
