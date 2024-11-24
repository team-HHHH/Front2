import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Screens/alarm_detail_screen.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _buttons = ["친구의 할일", "친구의 일기", "받은 좋아요", "소식"];
  int _selectedIndex = -1;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  String _currentText = "목록 없음"; // 기본 텍스트는 "목록 없음"
  String _nextText = "";
  bool _isTextVisible = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onButtonTap(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      // "소식 없음" 버튼 클릭 시
      if (index == 3) {
        _currentText = ""; // 소식 없음 화면 표시
        _isTextVisible = true;
      } else {
        _currentText = "목록 없음"; // 다른 버튼 클릭 시 "목록 없음"으로 설정
        _isTextVisible = false; // 기존 텍스트를 숨김
      }
      _selectedIndex = index; // 버튼 클릭된 상태 업데이트
      _nextText = "목록 없음";
    });

    if (index != 3) {
      // "소식 없음" 버튼이 아닌 경우 애니메이션 적용
      _animationController.forward(from: 0).then((_) {
        setState(() {
          _currentText = _nextText;
          _nextText = ""; // 새 텍스트 초기화
          _isTextVisible = true; // 새 텍스트는 보이게 설정
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          "알림",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: SSU_BLACK,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _buttons.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => _onButtonTap(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: isSelected ? SSU_BLACK : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _buttons[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : SSU_BLACK,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  AnimatedOpacity(
                    opacity: _isTextVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 0),
                    child: Text(
                      _currentText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: SSU_BLACK,
                      ),
                    ),
                  ),
                  if (_nextText.isNotEmpty && !_isTextVisible)
                    SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        _nextText,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: SSU_BLACK,
                        ),
                      ),
                    ),
                  if (_currentText == "")
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Get.to(const AlarmDetailScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 35, // 원의 크기 (이미지보다 약간 크게 설정)
                                      height: 35, // 원의 크기 (이미지보다 약간 크게 설정)
                                      decoration: BoxDecoration(
                                        color: Colors.white, // 원형 배경 색
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              SSU_BLACK, // 원 테두리 색 (원하는 색으로 변경)
                                          width: 1, // 테두리의 두께
                                        ), // 원 모양
                                      ),
                                      child: Image.asset(
                                        "assets/images/로고2.png",
                                        width: 14,
                                        height: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      // `RichText`가 공간을 차지하도록 함
                                      child: RichText(
                                        text: const TextSpan(
                                          text: '공지사항 : ', // 기본 스타일
                                          style: TextStyle(
                                            color: SSU_BLACK,
                                            fontSize: 12,
                                            fontWeight:
                                                FontWeight.bold, // "공지사항"은 두껍게
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "앱 업데이트 소식입니다."
                                                    "이번 업데이트에서는 포스터 요약 기능이 iOS 17.4 버전으로 업그레이드되었습니다."
                                                    "이제 iOS 17.4에서 제공하는 새로운 기능과 호환되어 보다 정확하고 빠른 요약 서비스를 제공할 수 있습니다."
                                                    "이를 통해 사용자들이...",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                ) // 기본 스타일 유지
                                                ),
                                            TextSpan(
                                              text: '4일전', // "14일전"은 엄청 얇게
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight:
                                                    FontWeight.normal, // 엄청 얇게
                                              ),
                                            ),
                                          ],
                                        ),
                                        softWrap: true, // 줄 바꿈 허용
                                        // 텍스트가 너무 길면 생략 처리
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
