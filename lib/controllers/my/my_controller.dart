import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/myProfileInfo_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_controller.dart';

class MyController extends BaseController {

  final globalCtrl = Get.find<GlobalController>();
  late MyProfileInfoModel myProfileInfoModel;

  List<Map<String, int>> myData = [];

  void myDataInfo(){
    myData.add({'등록제품보기': myProfileInfoModel.productCount});
    myData.add({'케어/수선이력': myProfileInfoModel.careCount});
    myData.add({'정품인증이력': myProfileInfoModel.activationCount});
  }
  Map<String, String> linkData = {
    '친구 초대 하기': '/main/my/invite',
    '제품 사용자 변경': '',
    '공지사항': '/main/my/notice',
    '자주 묻는 질문': '/main/my/question',
    '1:1 문의': '/main/my/inquiry',
    '설정': '/main/my/setting',
  };

  Map<String, String> infoLinkData = {
    '프로필 사진 등록 / 변경': 'profile',
    '아이디(이메일)' : 'email',
    '이름(닉네임) 변경' : '/main/my/info/name',
    '비밀번호 변경': '/main/my/info/password',
    '전화번호 변경': '/main/my/info/phone',
    '주소 등록 / 변경': '/main/my/info/address'
  };

  Rx<String> name = ''.obs;
  Rx<String> nowPassword = ''.obs;
  Rx<String> password = ''.obs;
  Rx<String> rePassword = ''.obs;
  Rx<String> phone = ''.obs;
  Rx<String> code = ''.obs;
  Rx<String> city = ''.obs;
  Rx<String> sigungu = ''.obs;
  Rx<String> street = ''.obs;
  Rx<String> address = ''.obs;
  Rx<String> detailAddress = ''.obs;
  Rx<String> postcode = ''.obs;

  TextEditingController nickNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

  Rx<bool> isAuth = false.obs;
  void initMyController(){
    name.value = '';
    password.value = '';
    rePassword.value = '';
    phone = ''.obs;
    code = ''.obs;
    isAuth.value = false;
    address = ''.obs;
    detailAddress = ''.obs;
    addressController = TextEditingController();
    addressDetailController = TextEditingController();
    postCodeController = TextEditingController();
  }

  Future<void> myInfo() async{
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await MyProvider().chkMyProfile(token!);
    if(res != null){
      myPageInfo(res);
    }else{
      Get.dialog(
        CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }
  }

  void myPageInfo(dynamic myProfileInfo){
    myProfileInfoModel = myProfileInfo;
    update();
  }

  Future<void> changeNickName(String name) async{
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await MyProvider().changeName(token!, name);
    if(res){
      myInfo();
      Get.back();
      update();
    }else{
      Get.dialog(
        CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }
  }

  Future<void> changePassword() async {
    if(password.value != rePassword.value){
      Get.dialog(
        CustomDialogWidget(content: '새로운 비밀번호가 서로 일치 하지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      final String? token = await SharedTokenUtil.getToken('userLogin_token');
      final res = await MyProvider().changePassword(token!, password.value, nowPassword.value);
      if(res != null){
        print(res.toString());
        if(res['code'] == "U003"){
          Get.dialog(
            CustomDialogWidget(content: '비밀번호가 올바르지 않습니다.', onClick: (){
              Get.back();
              update();
            }),
          );
        }else{
          Get.back();
        }
      }else{
        Get.dialog(
          CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }
    }
  }

  Future<void> changePhone(String name) async{
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await MyProvider().changeName(token!, name);
    if(res){
      myInfo();
      Get.back();
      update();
    }else{
      Get.dialog(
        CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }
  }

  Future<void> changeAddress() async{
    if(postCodeController.text == ""){
      Get.dialog(
        CustomDialogWidget(content: '우편번호가 입력되지 않았습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      final res = await MyProvider().changeAddress(
        token!,
        '${city.value} ${sigungu.value}',
        "${street.value} ${detailAddress}",
        postcode.value,
      );
      if(res){
        myInfo();
        Get.back();
        update();
      }else{
        Get.dialog(
          CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }
    }
  }

  void authChangePhone() {
    isAuth.value = true;
    update();
  }

  bool get passwordIsOn => nowPassword.isNotEmpty && password.value.isNotEmpty && rePassword.value.isNotEmpty && password.value == rePassword.value;
  bool get isPhone => phone.value.length == 11;
  bool get isCode => code.value.length == 6;
  bool get isAddress => address.value.isNotEmpty && detailAddress.value.isNotEmpty && postcode.value.isNotEmpty;

  @override
  void onInit() async{
    await myInfo();
    initMyController();
    myDataInfo();
    super.onInit();
  }
}
