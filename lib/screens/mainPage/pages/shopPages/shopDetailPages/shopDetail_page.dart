import 'dart:math';
import 'dart:io';
import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/bindings/mainShop_binding.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/mainShop_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopDetail/shopDetail_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListAll_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/shop_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopAddProductPages/shopAddProuct_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopModifiedPages/shopModified_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/add_genuineLogo.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_like_btn.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShopDetailPage extends GetView<ShopDetailController> {
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "SHOP",
      child: _renderBody(),
    );
  }

  _renderBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: GetBuilder<ShopDetailController>(
          builder: (_) => Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        //배너
                        Stack(
                          children: [
                            if (controller.model?.images.length != 0)
                              CarouselSlider(
                                carouselController: controller.slideCtrlBtn,
                                options: CarouselOptions(
                                  height: 240,
                                  aspectRatio: 16 / 9,
                                  initialPage: 0,
                                  enableInfiniteScroll:
                                      controller.model?.images.length == 1
                                          ? false
                                          : true,
                                  autoPlay: true,
                                  reverse: false,
                                  autoPlayInterval: Duration(seconds: 5),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  scrollDirection: Axis.horizontal,
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) =>
                                      controller.pageChanged(index),
                                ),
                                items: (controller.model?.images ??
                                        controller.testBanner)
                                    .map((e) {
                                  return Builder(
                                    builder: (context) {
                                      return InkWell(
                                        onTap: () =>
                                            Get.to(ImageDetailScreen()),
                                        child: Container(
                                          width: double.infinity,
                                          height: 360,
                                          child: ExtendedImage.network(
                                            BaseApiService.imageApi + e.path!,
                                            fit: BoxFit.cover,
                                            cache: true,
                                            // ignore: missing_return
                                            loadStateChanged:
                                                (ExtendedImageState state) {
                                              switch (state
                                                  .extendedImageLoadState) {
                                                case LoadState.loading:
                                                  break;
                                                case LoadState.completed:
                                                  break;
                                                case LoadState.failed:
                                                  break;
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            if (controller.model?.images.length != 0)
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Obx(() => Center(
                                              child: Text(
                                                "${controller.pageNum.value + 1}/${controller.model?.images.length ?? 0}",
                                                style:
                                                    regular12TextStyle.copyWith(
                                                        color: whiteColor),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (controller.model?.images.length != 0)
                              Positioned(
                                bottom: 0,
                                top: 0,
                                left: 15,
                                child: InkWell(
                                  onTap: () =>
                                      controller.slideCtrlBtn.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  ),
                                  child: Container(
                                    height: double.infinity,
                                    width: 25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Transform.rotate(
                                          angle: 180 * pi / 180,
                                          child: SvgPicture.asset(
                                              'assets/icons/slider_next.svg',
                                              height: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (controller.model?.images.length != 0)
                              Positioned(
                                bottom: 0,
                                top: 0,
                                right: 15,
                                child: InkWell(
                                  onTap: () => controller.slideCtrlBtn.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  ),
                                  child: Container(
                                    height: double.infinity,
                                    width: 25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/slider_next.svg',
                                            height: 25),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (controller.model?.images.length == 0)
                              Container(
                                width: double.infinity,
                                height: 240,
                                color: gray_CCCColor,
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/header_title_logo.svg",
                                    height: 40,
                                  ),
                                ),
                              ),
                            if (controller.model?.gi != "REFUSAL" &&
                                controller.model?.gi != "GOING")
                              Positioned(
                                right: 15,
                                top: 15,
                                child: GenuineLogo(
                                    genuine:
                                        controller.model?.gi == "UNCERTIFIED"
                                            ? false
                                            : controller.model?.gi == "REJECT"
                                                ? false
                                                : true),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 5, bottom: 5),
                                leading: controller.model == null
                                    ? Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF4F0FF),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                              "assets/icons/mypage_on.svg",
                                              height: 13),
                                        ),
                                      )
                                    : controller.model!.userProfile == null
                                        ? Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: Color(0xffF4F0FF),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                  "assets/icons/mypage_on.svg",
                                                  height: 13),
                                            ),
                                          )
                                        : Container(
                                            width: 32,
                                            height: 32,
                                            child: ClipOval(
                                              child: ExtendedImage.network(
                                                BaseApiService.imageApi +
                                                    controller
                                                        .model!.userProfile!,
                                                fit: BoxFit.cover,
                                                cache: true,
                                                // ignore: missing_return
                                                loadStateChanged:
                                                    (ExtendedImageState state) {
                                                  switch (state
                                                      .extendedImageLoadState) {
                                                    case LoadState.loading:
                                                      break;
                                                    case LoadState.completed:
                                                      break;
                                                    case LoadState.failed:
                                                      break;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                title: Text(
                                  "${controller.model?.nickName}",
                                ),
                                trailing: Container(
                                  width: 30,
                                  child: controller.isMyShop.value
                                      ? Container(
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: _simplePopup()),
                                        )
                                      : Container(),
                                ),
                              ),
                              const Divider(color: gray_f5f6f7Color, height: 1),
                              const SizedBox(height: 16),
                              Text(
                                "${controller.model?.title ?? "로딩중"}",
                                style: medium16TextStyle,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Text("${controller.model?.brand ?? "로딩중"}",
                                      style: regular12TextStyle.copyWith(
                                          color: gray_999Color)),
                                  const SizedBox(width: 8),
                                  VerticalDivider(
                                      width: 1, color: Color(0xff999999)),
                                  const SizedBox(width: 8),
                                  Text("${controller.model?.category ?? "로딩중"}",
                                      style: regular12TextStyle.copyWith(
                                          color: gray_999Color)),
                                  const SizedBox(width: 8),
                                  VerticalDivider(
                                      width: 1, color: Color(0xff999999)),
                                  const SizedBox(width: 8),
                                  Text(
                                    DateFormatUtil.convertDateTimeFormat(
                                        date:
                                            "${controller.model?.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                                    style: regular12TextStyle.copyWith(
                                        color: gray_999Color),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: double.infinity,
                                  minHeight: 189,
                                ),
                                child: Text(
                                  "${controller.model?.content ?? "로딩중"}",
                                  maxLines: 60,
                                  style: regular14TextStyle.copyWith(
                                      color: gray_333Color),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: double.infinity,
                      height: Platform.isIOS ? 80 : 64,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: Offset(0.0, -5.0)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GetBuilder<ShopDetailController>(
                              builder: (_) => CustomLikeBtn(
                                    isLiked: controller.model?.hasLike ?? false,
                                    onTap: () => controller.changeIsLiked(),
                                  )),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '가격',
                                style: regular12TextStyle.copyWith(
                                    color: gray_999Color),
                              ),
                              Text(
                                '${NumberFormatUtil.convertNumberFormat(number: controller.model?.price ?? 0)}원',
                                style: medium14TextStyle.copyWith(
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}

class ImageDetailScreen extends GetView<ShopDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Stack(
            children: [
              if (controller.model?.images.length != 0)
                CarouselSlider(
                  carouselController: controller.slideCtrlBtn,
                  options: CarouselOptions(
                    height: double.infinity,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    reverse: false,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) =>
                        controller.pageChanged(index),
                  ),
                  items: (controller.model?.images ?? controller.testBanner)
                      .map((e) {
                    return Builder(
                      builder: (context) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: ExtendedImage.network(
                            BaseApiService.imageApi + e.path!,
                            fit: BoxFit.fitWidth,
                            cache: true,
                            // ignore: missing_return
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  break;
                                case LoadState.completed:
                                  break;
                                case LoadState.failed:
                                  break;
                              }
                            },
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              if (controller.model?.images.length != 0)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Obx(() => Center(
                                child: Text(
                                  "${controller.pageNum.value + 1}/${controller.model?.images.length ?? 0}",
                                  style: regular12TextStyle.copyWith(
                                      color: whiteColor),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              if (controller.model?.images.length != 0)
                Positioned(
                  bottom: 0,
                  top: 0,
                  left: 15,
                  child: InkWell(
                    onTap: () => controller.slideCtrlBtn.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: Container(
                      height: double.infinity,
                      width: 25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: 180 * pi / 180,
                            child: SvgPicture.asset(
                                'assets/icons/slider_next.svg',
                                height: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (controller.model?.images.length != 0)
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 15,
                  child: InkWell(
                    onTap: () => controller.slideCtrlBtn.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: Container(
                      height: double.infinity,
                      width: 25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/slider_next.svg',
                              height: 25),
                        ],
                      ),
                    ),
                  ),
                ),
              if (controller.model?.images.length == 0)
                Container(
                  width: double.infinity,
                  height: 240,
                  color: gray_CCCColor,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/header_title_logo.svg",
                      height: 40,
                    ),
                  ),
                ),
              if (controller.model?.gi != "REFUSAL" &&
                  controller.model?.gi != "GOING")
                Positioned(
                  right: 15,
                  top: 15,
                  child: GenuineLogo(
                      genuine: controller.model?.gi == "UNCERTIFIED"
                          ? false
                          : controller.model?.gi == "REJECT"
                              ? false
                              : true),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _simplePopup() {
  final ShopDetailController shopDetailController = Get.find<ShopDetailController>();
  final MainShopController mainShopController = Get.find<MainShopController>();
  return PopupMenuButton<int>(
    tooltip: '메뉴',
    padding: EdgeInsets.symmetric(horizontal: 5),
    onSelected: (value) {
      if (value == 1) {
        Get.to(() => ShopModifiedPage(), binding: MainShopModifiedBinding());
      } else if (value == 2) {
        Get.dialog(CustomDialogWidget(
          isSingleButton: false,
          content: '게시물을 삭제하시겠습니까?',
          okTxt: '확인',
          cancelTxt: '취소',
          onClick: () async {
            Get.back();
            var result = await shopDetailController.delShopDetail();
            if(result){
              Get.dialog(
                  CustomDialogWidget(content: '게시물이 삭제되었습니다.', onClick: () async {
                    Get.back();
                    mainShopController.tabCtrl.index = 0;
                    mainShopController.tabBarListener(0);
                    Get.back();
                  })
              );
            }
            else {
              Get.dialog(
                  CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: () async {
                    Get.back();
                    mainShopController.tabCtrl.index = 0;
                    mainShopController.tabBarListener(0);
                    Get.back();
                  })
              );
            }


          },
          onCancelClick: () {
            Get.back();
          },
        ));
      }
    },
    itemBuilder: (context) =>
    [
      PopupMenuItem(
        value: 1,
        child: Center(child: Text("수정")),
        padding: EdgeInsets.symmetric(horizontal: 5),
      ),
      PopupMenuItem(
          value: 2,
          child: Center(
              child: Text(
                "삭제",
                style: TextStyle(color: Colors.red),
              )),
          padding: EdgeInsets.symmetric(horizontal: 5)),
    ],
  );
}

