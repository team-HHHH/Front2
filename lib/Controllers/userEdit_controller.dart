import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scheduler/Components/Alert.dart';
import 'package:scheduler/Components/ApiHelper.dart';

import 'package:get/get.dart';
import 'package:scheduler/Components/Reissue.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/token_controller.dart';
import 'package:scheduler/Controllers/userInfo_controller.dart';
import 'package:scheduler/Screens/login_screen.dart';
import 'package:scheduler/Screens/profile_screen.dart';
import 'package:scheduler/main.dart';

class UserChangeController extends GetxController {
  final TokenController tokenController = Get.put(TokenController());
  final userInfoCont = Get.put(UserinfoController());
  var nickname = "로딩 중 ... ";
  var loginId = "로딩 중 ... ";
  var address = "로딩 중 ... ";
  var email = "로딩 중 ... ";
  var profileImg = "로딩 중 ... ";

  var originPw = "";
  var newPw = "";

  var nicknameCheck = false;
  var emailCheck = false;

  Future<void> loadUserInfo() async {
    // 여기서 사용자 정보를 초기화
    await userInfoCont.getUserInfo();
    nickname = userInfoCont.nickname;
    email = userInfoCont.email;
    address = userInfoCont.address;
    profileImg = userInfoCont.profileImg;
  }

  void setNickname(String args) {
    nickname = args;
  }

  void setLoginId(String args) {
    loginId = args;
  }

  void setAddress(String args) {
    address = args;
  }

  void setEmail(String args) {
    email = args;
  }

  void setProfileImg(String args) {
    profileImg = args;
  }

  void setOriginPw(String args) {
    originPw = args;
  }

  void setNewPw(String args) {
    newPw = args;
  }

  Future<bool> nickname_checker() async {
    final url = Uri.http(SERVER_DOMAIN, "users/check/nickname");

    final response = await ssuPost(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"nickName": nickname}));
    if (response.statusCode != 200) return false;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();
    print(resultMessage);
    if (resultCode != 200) return false;

    if (responseData.getBodyValueOne("duplicated")) return false;

    print("true가 되어야할텐데..,");

    return true;
  }

  Future<int> email_sender() async {
    final url = Uri.http(SERVER_DOMAIN, "users/check/email");
    final response = await ssuPost(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": tokenController.accessToken.toString(),
        },
        body: jsonEncode({"email": email}));
    if (response.statusCode != 200) return 0;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();
    print(resultMessage);
    if (resultCode == 201) return 2;
    if (resultCode == 401) {
      // await tokenController.reissue();
      //await email_sender();
    }
    if (resultCode != 200) return 0;
    return 1;
  }

  Future<bool> email_checker(String code) async {
    code = code.trim();

    final url = Uri.http(SERVER_DOMAIN, "users/check/emailcode");
    final response = await ssuPost(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": tokenController.accessToken.toString(),
        },
        body: jsonEncode({"email": email, "emailCode": code}));

    if (response.statusCode != 200) return false;

    final responseData = ApiHelper(response.body);
    var resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();
    print(resultMessage);
    if (resultCode == 401) {
      print("in reissue");

      /// await tokenController.reissue();
      //await email_checker(code);
      resultCode = 200;
    }
    if (resultCode != 200) return false;

    final correct = responseData.getBodyValueOne("codeCorrect");
    return correct;
  }

  Future<void> changeUserInfo(BuildContext context) async {
    print(tokenController.accessToken);

    final url = Uri.http(SERVER_DOMAIN, "users");
    print(
        "[변경] nickname:" + nickname + ", email:" + email + ", addr:" + address);
    final response = await ssuPatch(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": tokenController.accessToken.toString(),
        },
        body: jsonEncode({
          "nickname": nickname,
          "address": address,
          "email": email,
        }));
    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();
    print(resultMessage);
    if (resultCode != 200) return;

    /*
    nickname = responseData.getBodyValueOne("nickname").toString();
    loginId = responseData.getBodyValueOne("loginId").toString();
    address = responseData.getBodyValueOne("address").toString();
    email = responseData.getBodyValueOne("email").toString();
    profileImg = responseData.getBodyValueOne("profileImg").toString();
    */

    print("$nickname : $address, id=$loginId");
    showAlertDialog(context, "수정 완료", const ProfileScreen());
  }

  Future<void> changeUserPasswd(BuildContext context) async {
    print(tokenController.accessToken);

    final url = Uri.http(SERVER_DOMAIN, "users/change-password");

    print("[변경] originPW:$originPw, newPW:$newPw");

    final response = await ssuPatch(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": tokenController.accessToken.toString(),
        },
        body: jsonEncode({"originPw": originPw, "newPw": newPw}));
    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();
    print(resultMessage);
    if (resultCode != 200) {
      showAlertDialog(context, "기존 비밀번호가 일치하지 않습니다", const ProfileScreen());
      return;
    }

    /*
    nickname = responseData.getBodyValueOne("nickname").toString();
    loginId = responseData.getBodyValueOne("loginId").toString();
    address = responseData.getBodyValueOne("address").toString();
    email = responseData.getBodyValueOne("email").toString();
    profileImg = responseData.getBodyValueOne("profileImg").toString();
    */

    print("$nickname : $address, id=$loginId");
    showAlertDialog(context, "비밀번호 변경 완료", LoginScreen());
  }

  Future<void> changeUserImg() async {}
}
