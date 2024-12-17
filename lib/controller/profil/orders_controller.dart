import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/data/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

abstract class OrdersController extends GetxController {
  fetchorders();
  ordersperday(DateTime selectedday);
}

class OrdersControllerImp extends OrdersController {
  @override
  void onInit() {
    fetchorders();
    ordersperday(selectedday);
    super.onInit();
  }

  bool isloading = false;

  List<OrderModel> userorders = [];

  DateTime selectedday = DateTime.now();

  updaetdate(DateTime date) {
    selectedday = date;
    update();
  }

  @override
  Future fetchorders() async {
    try {
      isloading = true;
      update();

      QuerySnapshot ordersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .get();

      userorders.clear();
      if (ordersSnapshot.docs.isNotEmpty) {
        for (var doc in ordersSnapshot.docs) {
          var order = OrderModel.fromJson(doc.data() as Map<String, dynamic>);
          order.id = doc.id;
          userorders.add(order);
        }
      }

     
    } catch (e) {
      return Get.rawSnackbar(
          title: "Error",
          message: "Please try again!",
          backgroundColor: AppColor.redcolor);
    }finally{
      isloading = false;
      update();
    }
  }

  @override
  List<OrderModel> ordersperday(DateTime selectedday) {
    List<OrderModel> orderperday = userorders.where((order) {
      return order.orderdate.day == selectedday.day &&
          order.orderdate.month == selectedday.month &&
          order.orderdate.year == selectedday.year;
    }).toList();
    update();
    return orderperday;
  }
}
