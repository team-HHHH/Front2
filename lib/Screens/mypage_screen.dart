import 'dart:convert';
import '../ConfigJH.dart';
import '../Components/UtilityJH.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  String _userImg = "assets/images/DefaultProfile.png";
  String _userNickName = "준혁이형 후계자";
  String _userEmail = "baejh724@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar("마이페이지", "준혁이형 뭐하노 url"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //버튼 1
            GestureDetector(
              onTap: () {
                print("버튼이 클릭되었습니다!");
                // 클릭 시 동작할 코드
              },
              child: Container(
                width: double.infinity, // 화면 가로 길이 전체
                height: 100, // 버튼 높이
                color: Colors.transparent, // 버튼 배경색 없음
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset(_userImg, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 10), // 아이콘과 텍스트 사이의 간격
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, //중앙 배치
                      crossAxisAlignment: CrossAxisAlignment.start, //왼쪽 정렬
                      children: [
                        Text(
                          _userNickName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _userEmail,
                          style: const TextStyle(
                            fontSize: 14,
                            color: GRAY,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: SSU_BLUE,
                    )
                  ],
                ),
              ),
            ),

            //구분 선 두는겨
            PreferredSize(
              preferredSize: const Size.fromHeight(1.0), // 구분선의 두께
              child: Divider(
                thickness: 1.0,
                height: 1.0,
                color: Colors.grey.shade300, // 구분선 색상
              ),
            ),
            Container(
              height: 30,
            ),
            const Text(
              "주요 기능",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            Container(
              height: 5,
            ),
            profileNaviBar("내 포스터 관리", "/myposter"),
            profileNaviBar("유사 포스터 찾기", "/likeposter"),
            profileNaviBar("주변 포스터 구경하기", "/otherposter"),
            profileNaviBar("찜 포스터 목록들", "/mylover"),
            dividerBar(),
            //GestureDetector(),
            //GestureDetector(),
            //GestureDetector(),
          ],
        ),
      ),
    );
  }
}
