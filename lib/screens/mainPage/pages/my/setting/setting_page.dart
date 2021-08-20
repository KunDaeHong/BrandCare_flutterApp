import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/setting_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/route_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: '설정',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _box(child: _itemToggle()),
                ...controller.linkData.entries.map(
                  (e) => _box(
                    child: RouteContainerWidget(route: e.value, title: e.key, arguments: {'title': e.key},),
                  ),
                ),
                _renderAdBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '앱 버전 정보 12.12.1.0',
                    style: regular14TextStyle.copyWith(color: gray_666Color),
                  ),
                ),
                ...controller.actionData.entries.map((e) => _box(
                    child: GestureDetector(
                      onTap: () {
                        if(e.value == 'logout') {
                          controller.showLogoutDialog();
                          return;
                        }
                        controller.showWithdrawalDialog();
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 9.0, bottom: 9.0),
                        child: Row(
                          children: [
                            Text(
                              e.key,
                              style: medium14TextStyle,
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              'assets/icons/btn_arrow_right.svg',
                              color: gray_666Color,
                            )
                          ],
                        ),
                      ),
                    ))),
              ],
            ),
          ),
        ));
  }

  Widget _box({required Widget child}) => Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: gray_F5F6F7Color))),
        child: child,
      );

  Widget _itemToggle() => Container(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 9.0, bottom: 9.0),
          child: Row(
            children: [
              Text(
                '알림설정',
                style: medium14TextStyle,
              ),
              const Spacer(),
              // Obx(() =>
              //     Transform.scale(
              //       transformHitTests: false,
              //       scale: 0.5, child: CupertinoSwitch(
              //         activeColor: primaryColor,
              //         value: controller.isAlarm.value,
              //         onChanged: (value) {
              //           controller.isAlarm.value = value;
              //         }),))
              Obx(() =>
                  SizedBox(
                    width: 30.4,
                    height: 20,
                    child: Transform.scale(
                      transformHitTests: false,
                      scale: .7,
                      child: CupertinoSwitch(
                        activeColor: primaryColor,
                        value: controller.isAlarm.value,
                        onChanged: (value) {
                          controller.isAlarm.value = value;
                        }),
                    ),
                  ))
            ],
          ),
        ),
      );

  Widget _renderAdBox() => Container(
        margin: const EdgeInsets.only(left: 16, top: 50, right: 16, bottom: 32),
        padding: const EdgeInsets.only(left: 24, top: 26, bottom: 28),
        height: 94,
        width: double.infinity,
        decoration: BoxDecoration(
          color: gray_AFColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '나의 소중한 명품\n인증받고, 케어받고, 관심받고',
          style: medium14TextStyle.copyWith(color: whiteColor),
        ),
      );
}