import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scheduler/Controllers/token_controller.dart';
import 'package:scheduler/Controllers/userInfo_controller.dart';
import 'package:scheduler/Controllers/logout_controller.dart';
import 'package:scheduler/Screens/login_screen.dart';
import 'package:scheduler/Screens/passwordEdit_screen.dart';
import 'package:scheduler/Screens/profileEdit_screen.dart';
import '../Components/UtilityJH.dart';
import '../ConfigJH.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userCont = Get.put(UserinfoController());
  final logoutCont = Get.put(LogoutController());

  String _userImg = "assets/images/DefaultProfile.png";

  String _userNickName = "로딩 중...";
  String _userEmail = "baejh724@gmail.com";
  String _userAddr = "서울 강남구 봉은사 5길";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    // 여기서 사용자 정보를 초기화
    await userCont.getUserInfo();
    setState(() {
      _userNickName = userCont.nickname;
      _userEmail = userCont.email;
      _userAddr = userCont.address;

      var profileImg = userCont.profileImg;
      if (profileImg != "temp::image") {
        profileImg = userCont.profileImg;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBarDefault("회원정보 수정", "수정", const ProfileEditScreen()),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20, //마진
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  //나중에 버튼으로 변경
                  child: Image.asset(
                    alignment: Alignment.center,
                    _userImg,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Container(
              height: 20,
            ), //Margin

            const Text(
              "회원정보",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),

            Container(
              height: 10,
            ), //Margin

            keyValueText("닉네임", _userNickName),
            keyValueText("이메일", _userEmail),
            keyValueText("주소", _userAddr),

            /************* 계정정보  *************/
            Container(
              height: 30,
            ), //Margin

            const Text(
              "계정 정보",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),

            Container(
              height: 10,
            ), //Margin
            //구분 선 두는겨
            profileNaviBar("비밀번호 변경", const PasswordEditScreen()),

            /************* 부가정보  *************/

            dividerBar(),
            Container(
              height: 30,
            ), //Margin
            grayTextButton("로그아웃", logoutCont),

            //grayTextButton("회원탈퇴", () {}),
          ],
        ),
      ),
    );
  }
}
