import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:scheduler/Components/ApiHelper.dart';
import 'package:scheduler/Components/Reissue.dart';
import 'package:scheduler/ConfigJH.dart';

class RegisterController extends GetxController {
  var enteredId = "".obs;
  var enteredPassword = "".obs;
  var enteredPassword2 = "".obs;
  var enteredEmail = "".obs;
  var enteredCode = "".obs;

  var isDuplicateId = "".obs;
  var isDuplicatedEmail = "".obs;

  var isReceivedCode = false.obs;
  var isCorrectCode = "".obs;

  void updateId(String id) {
    enteredId.value = id;
  }

  void updatePassword(String password) {
    enteredPassword.value = password;
  }

  void updatePassword2(String password) {
    enteredPassword2.value = password;
  }

  void updateEmail(String email) {
    enteredEmail.value = email;
  }

  void updateCode(String code) {
    enteredCode.value = code;
  }

  String getIdMessage() {
    if (enteredId.value.length < 4 || enteredId.value.length > 16) {
      return "  아이디는 4자이상 16자이하입니다.";
    }
    // 정규 표현식: 숫자와 영어만 포함되고 특수문자는 없음
    final RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');

    if (!regex.hasMatch(enteredId.value)) {
      return "  아이디는 영어,숫자만 가능합니다.";
    }

    if (isDuplicateId.value == "true") {
      return "  이미 존재하는 아이디입니다.";
    } else if (isDuplicateId.value == "false") {
      return "  사용 가능한 아이디입니다.";
    }

    return "";
  }

  String getPasswordMessage() {
    if (enteredPassword.value.length < 4 ||
        enteredPassword.value.length > 16 ||
        enteredPassword2.value.length < 4 ||
        enteredPassword2.value.length > 16) {
      return "  비밀번호는 4자이상 16자이하입니다.";
    }

    if (enteredPassword.value != enteredPassword2.value) {
      return "  동일한 비밀번호를 입력해주세요.";
    }

    return "  사용 가능한 비밀번호입니다.";
  }

  String getCodeMessage() {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (emailRegExp.hasMatch(enteredEmail.value)) {
      return "  올바른 이메일 형식이 아닙니다.";
    }

    if (isDuplicatedEmail.value == "true") {
      return "  이미 존재하는 이메일입니다.";
    } else {
      return "  6자리 코드를 입력하세요.";
    }
  }

  // ID 중복확인 버튼 터치 시
  void handleCheckId() async {
    final url = Uri.http(SERVER_DOMAIN, "users/check/id");
    final response = await ssuPost(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "loginId": enteredId.value,
        },
      ),
    );
    if (response.statusCode == 200) return;
    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    if (resultCode != 200) return;

    final resultMessage = responseData.getResultMessage();
    print(resultMessage);
    final isDuplicated =
        responseData.getBodyValue("duplicated").toString() == "true";

    isDuplicateId.value = isDuplicated ? "true" : "false";
  }

  // Email 인증하기 버튼 터치 시
  void handleReciveCode() async {
    final url = Uri.http(SERVER_DOMAIN, "users/check/email");
    final response = await ssuPost(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "email": enteredEmail.value,
        },
      ),
    );
    if (response.statusCode == 200) {
      isReceivedCode.value = false;
      return;
    }

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();

    if (resultCode != 200) {
      isReceivedCode.value = false;
      return;
    }

    final resultMessage = responseData.getResultMessage();
    print(resultMessage);

    final isDuplicated =
        responseData.getBodyValue("duplicated").toString() == "true";

    if (!isDuplicated) {
      isDuplicatedEmail.value = "false";
      isReceivedCode.value = true;
      return;
    }

    // 이미 존재하는 이메일
    isDuplicatedEmail.value = "true";
    isReceivedCode.value = false;
  }

  // Email 인증 버튼 터치 시
  void handleCheckCode() async {
    final url = Uri.http(SERVER_DOMAIN, "users/check/emailcode");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "email": enteredEmail.value,
          "emailcode": enteredCode.value,
        },
      ),
    );
    if (response.statusCode != 200) return;
    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();

    if (resultCode != 200) return;

    final resultMessage = responseData.getResultMessage();
    print(resultMessage);

    final correctCode =
        responseData.getBodyValue("codeCorrect").toString() == "true";

    isCorrectCode.value = correctCode ? "true" : "false";
  }

  // 계속하기 버튼 터치 시
  void handleNext() async {
    final url = Uri.http(SERVER_DOMAIN, "/users/register");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "email": enteredEmail.value,
          "loginId": enteredId.value,
          "password": enteredPassword.value,
        },
      ),
    );
    if (response.statusCode != 200) return;
    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();

    if (resultCode != 200) return;

    final resultMessage = responseData.getResultMessage();
    print(resultMessage);
  }
}
