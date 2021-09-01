import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/models/shop/addProductShop_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../base_api_service.dart';
import 'package:http_parser/http_parser.dart';

class ProductApiService {

  Future<dynamic> addProduct(
      dynamic headers,
      dynamic body,
      List<File> images,
      File frontImg,
      File backImg,
      File leftImg,
      File rightImg) async {
    try {
      final uri = Uri.parse("${BaseApiService.baseApi}/product/apply");
      var req = http.MultipartRequest('POST', uri);
      req.files.add(
        http.MultipartFile.fromBytes(
          'dto',
          utf8.encode(body),
          contentType: MediaType(
            'application',
            'json',
            {'charset': 'utf-8'},
          ),
        ),
      );
      //이미지 리스트
      for (var file in images) {
        List<int> imageData = file.readAsBytesSync();
        req.files.add(
          http.MultipartFile.fromBytes(
            'images',
            imageData,
            filename: file.path
                .split("/")
                .last,
          ),
        );
      }
      //앞면 이미지
      req.files.add(
        http.MultipartFile.fromBytes(
          'frontImage',
          frontImg.readAsBytesSync(),
          filename: frontImg.path.split("/").last
        ),
      );
      //뒷면 이미지
      req.files.add(
        http.MultipartFile.fromBytes(
            'backImage',
            backImg.readAsBytesSync(),
            filename: backImg.path.split("/").last
        ),
      );
      //왼쪽 이미지
      req.files.add(
        http.MultipartFile.fromBytes(
            'leftImage',
            leftImg.readAsBytesSync(),
            filename: leftImg.path.split("/").last
        ),
      );
      //오른쪽 이미지
      req.files.add(
        http.MultipartFile.fromBytes(
            'rightImage',
            rightImg.readAsBytesSync(),
            filename: rightImg.path.split("/").last
        ),
      );
      req.headers.addAll(headers);
      http.StreamedResponse res = await req.send();
      final resReturn = await res.stream.bytesToString();
      print(res.statusCode);
      if (res.statusCode == 200) {
        return resReturn;
      } else {
        return null;
      }
    } catch (e) {
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }


  Future<http.Response?> getMyProduct(String token) async {
    late http.Response res;
    try{
      res = await http.get(Uri.parse('${BaseApiService.baseApi}/product/mine?page=1&sort=LATEST'),
          headers: BaseApiService.authHeaders(token));
      if(res.statusCode == 200) {
        return res;
      }
    }catch(e){
      return null;
    }
  }

  changeProduct({required String token, required Map<String, dynamic> data}) async {
    late http.Response res;
    try {
      res = await http.post(Uri.parse('${BaseApiService.baseApi}/product/apply/change'),
          headers: BaseApiService.authHeaders(token),
          body: json.encode(data)
      );
      print('changeProdyct');
      print(res.body);
      if(res.statusCode == 200) {
        return res;
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  changeProductAccept(String token, Map<String, dynamic> data) async {
    late http.Response res;
    try {
      res = await http.post(Uri.parse('${BaseApiService.baseApi}/product/apply/change/accept'),
          headers: BaseApiService.authHeaders(token),
          body: json.encode(data)
      );
      print('changeProdyct');
      print(res.body);
      if(res.statusCode == 200) {
        return res;
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  changeProductCancel(String token, Map<String, dynamic> data) async {
    late http.Response res;
    try {
      res = await http.post(Uri.parse('${BaseApiService.baseApi}/product/apply/change/cancel'),
          headers: BaseApiService.authHeaders(token),
          body: json.encode(data)
      );
      print('changeProdyct');
      print(res.body);
      if(res.statusCode == 200) {
        return res;
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  getProductChangeList(String token, String status) async {
    late http.Response res;
    try {
      res = await http.get(Uri.parse('${BaseApiService.baseApi}/product/change?status=$status'),
          headers: BaseApiService.authHeaders(token),
      );
      print(res.body);
      if(res.statusCode == 200) {
        return res;
      }
    }catch(e){
      print(e);
      return null;
    }
  }


  getProductChangeOnce(String token, int id, String status) async {
    late http.Response res;
    try {
      res = await http.get(Uri.parse('${BaseApiService.baseApi}/product/change/$id?status=$status'),
        headers: BaseApiService.authHeaders(token),
      );
      print(res.body);
      if(res.statusCode == 200) {
        return res;
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  getProductDetail(String token, int id) async {
    late http.Response res;
    try {
      res = await http.get(Uri.parse('${BaseApiService.baseApi}/product/$id'),
        headers: BaseApiService.authHeaders(token),
      );
      print(res.body);
      if(res.statusCode == 200) {
        return res;
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<http.Response?> productDetail(dynamic headers, int idx) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/product/$idx");
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> productRemove(dynamic headers, int idx) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/product/apply/$idx");
      final http.Response res = await http.delete(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> productGenuineAdd(dynamic headers, dynamic body) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/activation");
      final http.Response res = await http.post(
        uri,
        headers: headers,
        body: body,
      );
      print(res.body.toString());
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> genuineStatus(dynamic headers, int idx) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/activation/$idx");
      final http.Response res = await http.delete(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> brandCategory(dynamic headers) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/product/brand");
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> categoryNameList(dynamic headers) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/product/category");
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

}