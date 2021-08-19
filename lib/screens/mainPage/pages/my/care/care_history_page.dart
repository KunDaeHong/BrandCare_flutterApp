import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/care_history_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CareHistoryPage extends GetView<CareHistoryController> {
  const CareHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: '케어/수선 이력',
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _renderProfile(),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: SvgPicture.asset('assets/icons/filter.svg'),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Flexible(
                  child: ListView.separated(
                      itemBuilder: (context, idx) => _item(),
                      separatorBuilder: (context, idx) => const Divider(height: 0, thickness: 1,),
                      itemCount: 10))
            ],
          ),
        ));
  }

  Widget _renderProfile() => Container(
    padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 24),
    decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          defaultBoxShadow,
        ]),
    child: Row(
      children: [
        Container(
          width: 59,
          height: 50,
          child: SvgPicture.asset('assets/icons/person_outline.svg'),
        ),
        const SizedBox(
          width: 24,
        ),
        Flexible(
          child: Container(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이재룡 님',
                  style: medium14TextStyle.copyWith(color: primaryColor),
                ),
                const Spacer(),
                Text(
                  '케어/수선 완료 10건',
                  style: regular12TextStyle.copyWith(color: primaryColor),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );

  Widget _item() => Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              'xx외 n건',
              style: medium14TextStyle,
            ),
            const Spacer(),
            Text(
              '진행중',
              style: medium14TextStyle.copyWith(color: gray_333Color),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Text(
              '',
              style: medium14TextStyle,
            ),
            const Spacer(),
            Text(
              '17:30 | 2021-02-05',
              style: regular14TextStyle.copyWith(color: gray_333Color),
            )
          ],
        )
      ],
    ),
  );
}
