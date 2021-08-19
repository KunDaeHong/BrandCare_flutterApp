import 'package:brandcare_mobile_flutter_v2/controllers/auth/login_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/auth/signup_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/setting_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/inquiry_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/splash_controller.dart';
import 'package:get/get.dart';

class InquiryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InquiryController());
  }

}