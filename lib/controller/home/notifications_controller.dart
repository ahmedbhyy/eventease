import 'package:get/get.dart';

abstract class NotificationsController extends GetxController {
  updatecolor();
}

class NotificationsControllerImp extends NotificationsController {
  bool isselected = false;
  @override
  updatecolor() {
    isselected = !isselected;
    update();
  }
}
