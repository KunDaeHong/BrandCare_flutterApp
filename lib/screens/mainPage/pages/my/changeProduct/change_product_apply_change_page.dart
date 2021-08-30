import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/change_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_tile_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChangeProductApplyChangePage extends StatelessWidget {
  ChangeProductApplyChangePage({Key? key}) : super(key: key);

  final controller = Get.find<ChangeProductController>();
  late Widget customExpansionTile;
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return DefaultAppBarScaffold(
      title: '제품 사용자 변경',
      isLeadingShow: false,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('나의 제품', style: medium14TextStyle,),
                  const SizedBox(height: 10,),
                  // GetBuilder<ChangeProductController>(builder: (_){
                  //   print('my product builder');
                  //   return _my_product();
                  // }),
                  _my_product(),
                  const SizedBox(height: 16,),
                  FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(),
                    title: '현재 사용자 아이디(이메일)',
                    isShowTitle: true,
                    hint: 'test01@test.com',
                    readOnly: true,
                  ),
                  const SizedBox(height: 16,),
                  FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(
                    text: controller.userEmail.value
                  ),
                    readOnly: true,
                    title: '변경할 사용자 아이디(이메일)',
                    isShowTitle: true,
                    hint: '변경할 사용자 아이디(이메일)를 입력해주세요.',
                  ),
                  const SizedBox(height: 60,),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Text('제품 사용자 변경으로 돌아가기', style: medium14TextStyle,),
                        const Spacer(),
                        SvgPicture.asset('assets/icons/btn_arrow_right.svg', color: gray_666Color,),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            const Spacer(),
            Center(
              child: Text('변경할 사용자의 확인을 기다리는 중입니다.\n"확인중" 버튼을 누를 시 변경 요청이 취소 됩니다.',
                textAlign: TextAlign.center,
                style: regular14TextStyle.copyWith(color: gray_999Color),
              ),
            ),
            const SizedBox(height: 34,),
            CustomButtonEmptyBackgroundWidget(
              title: '확인 중',
              onClick: (){
                // Get.back();
              },
              radius: 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _my_product() => Container(
    padding: const EdgeInsets.only(top: 14, bottom: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: gray_D5D7DBColor),
    ),
    child: IgnorePointer(
      ignoring: true,
      child: CustomExpantionTile2(
        isShowShadow: false,
        title: _title(),
        child: _child(),
      ),
    ),
  );

  Widget _title() => Container(
    child:_titleItem(1),
    // child: Text('123'),
  );

  Widget _child() => Container(
    constraints: BoxConstraints(
      maxHeight: 72 * 4 + 25,
    ),
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, idx) => Padding(
      padding: EdgeInsets.only(bottom: 8.0, top: idx ==0 ? 18 : 0),
      child: _item(idx),
    ), shrinkWrap: true,),
  );

  Widget _item(int idx) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: (){
      controller.updateSelectIdx(idx);
    },
    child: Container(
      padding: const EdgeInsets.only(left: 24, right: 48),
      height: 72,
      child: Row(
        children: [
          Image.asset(
            'assets/icons/sample_product.png',
            width: 72,
            height: 72,
          ),
          const SizedBox(
            width: 32,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '루이비통 | 가방',
                      style: regular12TextStyle.copyWith(color: gray_333Color),
                    ),
                    const Spacer(),
                    if(idx != 3)
                      GenuineBoxWidget(isGenuine: idx.isEven),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '나의 에쁜이$idx',
                  style: medium14TextStyle,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );

 Widget _titleItem(int idx) => GestureDetector(
   behavior: HitTestBehavior.translucent,
   onTap: (){
     Get.toNamed('/main/my/change_product/history/product/info');
   },
   child: Container(
     padding: const EdgeInsets.only(left: 24 - 16, right: 48 - 16),
     height: 72,
     child: Row(
       children: [
         Image.asset(
           'assets/icons/sample_product.png',
           width: 72,
           height: 72,
         ),
         const SizedBox(
           width: 16,
         ),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Row(
               children: [
                 Text(
                   '루이비통 | 가방',
                   style: regular12TextStyle.copyWith(color: gray_333Color),
                 ),
                 // const Spacer(),
                 const SizedBox(width: 19),
                 if(idx != 3)
                   GenuineBoxWidget(isGenuine: idx.isEven),
               ],
             ),
             const SizedBox(
               height: 16,
             ),
             Text(
               '나의 에쁜이$idx',
               style: medium14TextStyle,
             )
           ],
         )
       ],
     ),
   ),
 );
}