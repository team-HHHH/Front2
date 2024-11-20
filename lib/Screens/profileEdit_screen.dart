import 'dart:convert';
import 'package:get/get.dart';
import 'package:scheduler/Components/ButtonContainer.dart';
import 'package:scheduler/Controllers/logout_controller.dart';
import 'package:scheduler/Controllers/userEdit_controller.dart';
import 'package:scheduler/Controllers/userInfo_controller.dart';
import 'package:scheduler/Screens/profile_screen.dart';

import '../ConfigJH.dart';
import '../Components/UtilityJH.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final userCont = Get.put(UserChangeController());

  String _userNickName = "로딩 중...";
  String _userEmail = "baejh724@gmail.com";
  String _userAddr = "서울 강남구 봉은사 5길";

  final TextEditingController _newNicknameController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _newEmailCodeController = TextEditingController();
  final TextEditingController _newAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    await userCont.loadUserInfo();

    // 여기서 사용자 정보를 초기화
    setState(() {
      _userNickName = userCont.nickname;
      _userEmail = userCont.email;
      _userAddr = userCont.address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBarDefault("회원정보 수정", "", null),
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
                "회원정보",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlueButton(
              controller: _newNicknameController,
              hint_text: _userNickName,
              context: context,
              buttonName: "중복확인",
              type1: "닉네임이 중복됩니다",
              type2: "닉네임이 중복되지 않습니다",
              handler: () async {
                _newNicknameController.text != ""
                    ? userCont.setNickname(_newNicknameController.text)
                    : userCont.setNickname(_userNickName);
                return await userCont.nickname_checker();
              },
            ),
            BlueButtonEmail(
              controller: _newEmailController,
              controller_check: _newEmailCodeController,
              hint_text: _userEmail,
              hint_text_code: "인증코드(6자리)",
              context: context,
              buttonName: "이메일 전송하기",
              buttonName_code: "인증하기",
              type1: "일치하지 않는 코드입니다",
              type2: "인증에 성공하셨습니다",
              type3: "변경하시려면 새로운 이메일을 입력해주세요",
              handler: () async {
                _newEmailController.text != ""
                    ? userCont.setEmail(_newEmailController.text)
                    : userCont.setEmail(_userEmail);
                return await userCont.email_sender();
              },
              send_handler: () async {
                return await userCont
                    .email_checker(_newEmailCodeController.text);
              },
            ),
            grayInputLongWithSearch(_newAddressController, _userAddr, context),

            /*** 제출 ****/
            Container(
              height: 20, //마진
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () async {
                  _newNicknameController.text != ""
                      ? userCont.setNickname(_newNicknameController.text)
                      : userCont.setNickname(_userNickName);
                  _newEmailController.text != ""
                      ? userCont.setEmail(_newEmailController.text)
                      : userCont.setEmail(_userEmail);
                  _newAddressController.text != ""
                      ? userCont.setAddress(_newAddressController.text)
                      : userCont.setAddress(_userAddr);
                  await userCont.changeUserInfo(context);
                },
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  "회원정보 변경",
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
