import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:scheduler/Components/Alert.dart';
import 'package:scheduler/Components/ApiHelper.dart';

import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_story.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/token_controller.dart';
import 'package:scheduler/Screens/login_screen.dart';
import 'package:scheduler/Screens/profile_screen.dart';
import 'package:scheduler/Screens/register_detail_screen.dart';
import 'package:scheduler/Screens/register_screen.dart';

// 로그인과 관련된 비즈니스 로직 수행
//
// 1) 로그인 버튼 클릭 시
// 2) 카카오 로그인 클릭 시
// 3) 구글 로그인 클릭 시
class LoginController extends GetxController {
  final TokenController tokenController = Get.put(TokenController());
  var enteredId = ''.obs;
  var enteredPassword = ''.obs;

  void updateId(String id) {
    enteredId.value = id;
  }

  void updatePassword(String password) {
    enteredPassword.value = password;
  }

  // 로그인 버튼 누를 시 수행.
  void handleLogin(BuildContext context) async {
    final url = Uri.http(SERVER_DOMAIN, "users/login/custom");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "loginId": enteredId.value,
          "password": enteredPassword.value,
        },
      ),
    );
    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();
    print(resultMessage);

    /// 2024.10.29 JH --> Modifiy Region
    if (resultCode == 202) {
      showAlertDialog(context, "비밀번호가 틀렸습니다", LoginScreen());
      return;
    } else if (resultCode != 200) return;

    final isFirstLogin =
        responseData.getBodyValueOne("firstLogin").toString() == "true";

    final accessToken = response.headers["authorization"];
    final refreshToken = response.headers["refresh"];

    print(accessToken);
    tokenController.setAccessToken(accessToken.toString());
    tokenController.setRefreshToken(refreshToken.toString());
    if (isFirstLogin) {
      print("초기 로그인");
    }

    //// Debugging

    Get.to(const ProfileScreen());
  }

  void handleRegister() {
    Get.to(RegisterScreen());
  }

  // Oauth 로그인 버튼 클릭 시
  void handleOauthLogin(String sns) async {
    (String, String)? info;
    info = (sns == "kakao") ? await _getKakaoInfo() : await _getGoogleInfo();
    if (info == null) return;

    final (email, userCode) = info;

    // Oauth 로그인 시도(이미 회원인가 확인)
    final isFirstLogin = await _tryOauthLogin(email, userCode);

    // 처음 로그인이라면? 회원가입해야함.
    if (isFirstLogin) {
      await _registerOauthInfo(email, userCode);
      Get.to(() => const RegisterDetailScreen());
    }
  }

  // 카카오 로그인 시 정보를 가져옵니다.
  Future<(String, String)?> _getKakaoInfo() async {
    // 카카오톡이 설치되어 있다면?
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
        } catch (error) {}
      }
      // 카카오톡 설치안되어 있다면?
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
      } catch (error) {}
    }

    try {
      User user = await UserApi.instance.me();

      final String email = user.kakaoAccount!.email!;
      final String userCode = user.id.toString();

      return (email, userCode);
    } catch (error) {}

    return null;
  }

  // Oauth 로그인을 시도합니다.
  // true : 첫 로그인이므로 회원가입 창으로 이동.
  // false : 이미 가입한 회원이므로 다음 창으로 이동.
  Future<bool> _tryOauthLogin(String email, String userCode) async {
    final url = Uri.parse("/users/login/oauth");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "loginId": userCode,
          "password": email,
        },
      ),
    );
    if (response.statusCode != 200) return false;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();

    if (resultCode != 200) return false;

    final isFirstLogin =
        responseData.getBodyValue("isFirstLogin").toString() == "true";

    return isFirstLogin;
  }

  Future<void> _registerOauthInfo(String email, String userCode) async {
    final url = Uri.parse("/users/register");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "email": email,
          "id": userCode,
        },
      ),
    );
    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();

    if (resultCode != 200) return;

    final receivedEmail = responseData.getBodyValue("email").toString();
    final loginId = responseData.getBodyValue("loginId").toString();
    final password = responseData.getBodyValue("password").toString();
  }

  Future<(String, String)?> _getGoogleInfo() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;
    final email = googleUser.email;
    final userCode = googleUser.id;
    return (email, userCode);
  }
}
