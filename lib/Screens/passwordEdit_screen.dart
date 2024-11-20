import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scheduler/Components/ButtonContainer.dart';
import 'package:scheduler/Controllers/register_controller.dart';
import 'package:scheduler/Controllers/userEdit_controller.dart';
import 'package:scheduler/Controllers/userInfo_controller.dart';

import '../Components/UtilityJH.dart';
import '../ConfigJH.dart';

class PasswordEditScreen extends StatefulWidget {
  const PasswordEditScreen({super.key});

  @override
  State<PasswordEditScreen> createState() => _PasswordEditScreenState();
}

class _PasswordEditScreenState extends State<PasswordEditScreen> {
  final registerCont = Get.put(RegisterController());
  final changeCont = Get.put(UserChangeController());

  final _formKey = GlobalKey<FormState>(); // Form 위젯을 위해 사용.
  final TextEditingController _originpw = TextEditingController();
  final TextEditingController _newpw1 = TextEditingController();
  final TextEditingController _newpw2 = TextEditingController();

  // 상태를 저장할 변수
  bool _input_not_empty = false;
  bool _passwordsMatch = true;

  @override
  void initState() {
    super.initState();

    // 텍스트 필드의 값이 변경될 때마다 상태를 업데이트합니다.
    _newpw1.addListener(_checkPasswordsMatch);
    _newpw2.addListener(_checkPasswordsMatch);
  }

  void _checkPasswordsMatch() {
    setState(() {
      _input_not_empty = _newpw1.text.isNotEmpty && _newpw2.text.isNotEmpty;
      _passwordsMatch = _newpw1.text == _newpw2.text;
    });
  }

  @override
  void dispose() {
    _newpw1.dispose();
    _newpw2.dispose();
    super.dispose();
  }

  // 로그인 버튼 누를 시 수행.
  void handleLogin() async {
    if (_newpw1.text == "" ||
        _newpw2.text == "" ||
        _newpw1.text != _newpw2.text) {
      return;
    }

    final url = Uri.parse("");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "nickname": _newpw1.text,
          "address": _newpw2.text,
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // result 객체 추출
      final Map<String, dynamic> result = responseData['result'];
      final int resultCode = result['resultCode'];
      final String resultMessage = result['resultMessage'];

      // body 객체 추출
      final Map<String, dynamic> body = responseData['body'];
      final String isFirstLogin = body['isFirstLogin'];

      final headers = response.headers;
      final accessToken = headers["Authorization"];
      final refreshToken = headers["refresh"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBarDefault("비밀번호 변경", "", "준혁이형 뭐하노 url"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20, //마진
            ),
            Container(
              height: 40,
              child: const Text(
                "비밀번호 변경",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            grayInputLong(_originpw, "기존 비밀번호를 입력하세요", context, true),
            Container(
              height: 20, //마진
            ),
            grayInputLong(_newpw1, "새로운 비밀번호를 입력하세요", context, true),
            Container(
              height: 20, //마진
            ),
            grayInputLong(_newpw2, "비밀번호를 한번 더 입력하세요", context, true),
            Container(
              height: 20, //마진
            ),
            if (_input_not_empty)
              if (!_passwordsMatch)
                Container(
                  height: 20,
                  child: const Text(
                    "동일한 비밀번호를 입력해주세요!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 11,
                    ),
                  ),
                )
              else
                Container(
                  height: 20,
                  child: const Text(
                    "동일한 비밀번호입니다!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 11,
                    ),
                  ),
                ),
            /*** 제출 ****/
            Container(
              height: 20, //마진
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () {
                  if (_passwordsMatch && _input_not_empty) {
                    changeCont.setOriginPw(_originpw.text);
                    changeCont.setNewPw(_newpw1.text);
                    changeCont.changeUserPasswd(context);
                  }
                  //_formKey.currentState!.save();
                },
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  "비밀번호 변경",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
