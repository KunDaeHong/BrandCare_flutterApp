import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get.dart';

class GuideController extends BaseController {

  Rx<int> pageNum = 0.obs;
  CarouselController sliderCtrl = CarouselController();

  List<String> bannerList = [
    "assets/guide/guide1.png",
    "assets/guide/guide2.png",
    "assets/guide/guide3.png",
    "assets/guide/guide4.png",
  ];

  void changeBannerImg(int idx) {
    print(idx);
    this.pageNum.value = idx;
    update();
  }

  void saveGuideToken()async{
    SharedTokenUtil.saveBool(true, "isGuide");
    Get.offAllNamed("/splash");
  }

  @override
  void onInit() {
    super.onInit();
  }
}