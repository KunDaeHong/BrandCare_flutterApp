import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareStatus_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/status_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddCareStatusPage extends GetView<AddCareStatusController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: DefaultAppBarScaffold(
        title: "제품 케어 신청현황",
        child: _renderBody(),
        isLeadingShow: false,
      ),
      //onWillPop: () => Future(() => false),
      onWillPop: () => Future(() => true),
    );
  }

  _renderBody(){
    return GetBuilder<AddCareStatusController>(builder: (_) =>Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  _productInfo(
                    imgPath: "${_.careStatus?.careProduct[0].image}",
                    title: "${_.careStatus?.careProduct[0].category} 외 ${_.careStatus?.careProduct.length}건",
                    type: StatusUtil.statusChk(status: "${_.careStatus?.status}"),
                    clock: DateFormatUtil.convertOnlyTime(date: "${_.careStatus?.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                    date: DateFormatUtil.convertOnlyDate(date: "${_.careStatus?.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    itemCount: controller.careStatusJson.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx){
                      return _status(
                        title: controller.careStatusJson[idx]['statusType'],
                        date: DateFormatUtil.convertOnlyDate(date: controller.careStatusJson[idx]['date']),
                        time: DateFormatUtil.convertOnlyTime(date: controller.careStatusJson[idx]['time']),
                        isNext: idx == controller.careStatusJson.length - 1 ? false : true,
                        checked: controller.careStatusJson[idx]['checked'],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomButtonOnOffWidget(
                    title: '케어/수선 결과보기',
                    onClick: () {
                      controller.detail();
                    },
                    isOn: controller.fill.value,
                    radius: 30,
                  ),
                  const SizedBox(height: 24),
                  Text('물품명', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  _inputField('${_.careStatus?.careProduct[0].category} 외 ${_.careStatus?.careProduct.length}건'),
                  const SizedBox(height: 24),
                  Text('케어항목', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _.careStatus?.careProduct.length,
                    itemBuilder: (context, idx){
                      return _inputField("${_.careStatus?.careProduct[idx].category}");
                    },
                  ),
                  const SizedBox(height: 24),
                  Text('택배 반송 주소', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _backPost(_.careStatus?.returnType == "SENDER" ? true : false, "보내는 분"),
                      const SizedBox(width: 47),
                      _backPost(_.careStatus?.returnType != "SENDER" ? true : false, "받는 분"),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('이름', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  _inputField(_.careStatus?.returnType == "SENDER" ? "${_.careStatus?.sender.name}" : "${_.careStatus?.receiver.name}"),
                  const SizedBox(height: 24),
                  Text('전화번호', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  _inputField(_.careStatus?.returnType == "SENDER" ? "${_.careStatus?.sender.phone}" : "${_.careStatus?.receiver.phone}"),
                  const SizedBox(height: 24),
                  Text('주소', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  _inputField(_.careStatus?.returnType == "SENDER" ?
                  "${_.careStatus?.sender.address.city}":
                  "${_.careStatus?.receiver.address.city}"),
                  const SizedBox(height: 10),
                  _inputField(_.careStatus?.returnType == "SENDER" ?
                  "${_.careStatus?.sender.address.street}":
                  "${_.careStatus?.receiver.address.street}"),
                  const SizedBox(height: 24),
                  Text('요청사항', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  _inputField("${_.careStatus?.request_term}"),
                  const SizedBox(height: 24),
                  Text('케어/수선 서비스 참고 사진첨부', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  ListView.builder(
                    itemCount: _.careStatus!.careProduct.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx){
                      return _carePictures(
                          'assets/icons/sample_product.png',
                          '케어/수선 ${idx+1}'
                      );
                    },
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomButtonEmptyBackgroundWidget(
              title: "확인",
              onClick: () => controller.nextLevel(),
            ),
          ),
        ],
      ),
    ));
  }

  _backPost(bool isChecked, String title){
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isChecked ? primaryColor : whiteColor,
            border: Border.all(width: 1, color: primaryColor),
          ),
        ),
        const SizedBox(width: 8),
        Text(title, style: regular14TextStyle.copyWith(color: gray_666Color)),
      ],
    );
  }

  _carePictures(String imgPath, String title){
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
      width: double.infinity,
      height: 354,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: gray_D5D7DBColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title", style: regular14TextStyle),
          const SizedBox(height: 10),
          imgPath == "" ?
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              border: Border.all(color: gray_999Color),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/header_title_logo.svg",
                height: 10,
              ),
            ),
          ):
          ExtendedImage.network(
            BaseApiService.imageApi+imgPath,
            fit: BoxFit.cover,
            cache: true,
            // ignore: missing_return
            loadStateChanged: (ExtendedImageState state) {
              switch(state.extendedImageLoadState) {
                case LoadState.loading :
                  break;
                case LoadState.completed :
                  break;
                case LoadState.failed :
                  break;
              }
            },
          ),
        ],
      ),
    );
  }

  _inputField(String title){
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: gray_D5D7DBColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: regular14TextStyle),
        ],
      ),
    );
  }

  _productInfo({required String imgPath, required String title, required String type, required String clock, required String date}){
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imgPath == "" ?
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  border: Border.all(color: gray_999Color),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/header_title_logo.svg",
                    height: 10,
                  ),
                ),
              ):
              ExtendedImage.network(
                BaseApiService.imageApi+imgPath,
                fit: BoxFit.cover,
                cache: true,
                width: 72,
                height: 72,
                // ignore: missing_return
                loadStateChanged: (ExtendedImageState state) {
                  switch(state.extendedImageLoadState) {
                    case LoadState.loading :
                      break;
                    case LoadState.completed :
                      break;
                    case LoadState.failed :
                      break;
                  }
                },
              ),
              const SizedBox(width: 32),
              Text(
                '$title',
                style: medium14TextStyle,
              )
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$type',
                    style: medium14TextStyle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        clock,
                        style: regular14TextStyle,
                      ),
                      const SizedBox(width: 8),
                      Container(width: 1, height: 12, color: gray_999Color),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: regular14TextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _status({required String title, required String date, required String time, required bool isNext, required bool checked}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: checked ? whitePrimaryColor : gray_F2F5F6Color,
                  ),
                  child: Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: checked ? primaryColor : Colors.transparent,
                      ),
                    ),
                  ),
                ),
                isNext ?
                Container(
                  width: 1,
                  height: 24,
                  color: gray_F2F5F6Color,
                ): Container(),
              ],
            ),
            const SizedBox(width: 17),
            Text(title, style: medium14TextStyle),
          ],
        ),
        checked ? Row(
          children: [
            Text(
              date,
              style: regular14TextStyle,
            ),
            const SizedBox(width: 8),
            Container(width: 1, height: 12, color: gray_999Color),
            const SizedBox(width: 8),
            Text(
              time,
              style: regular14TextStyle,
            ),
          ],
        ) : Container(),
      ],
    );
  }
}
