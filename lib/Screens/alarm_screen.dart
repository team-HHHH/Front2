import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/ConfigJH.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _buttons = ["친구의 할일", "친구의 일기", "받은 좋아요", "소식 없음"];
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
        _currentText = "소식 없음 화면"; // 소식 없음 화면 표시
        _isTextVisible = true; // 텍스트는 바로 표시
      } else {
        _currentText = "목록 없음"; // 다른 버튼 클릭 시 "목록 없음"으로 설정
        _isTextVisible = false; // 기존 텍스트를 숨김
      }
      _selectedIndex = index; // 버튼 클릭된 상태 업데이트
      _nextText = _buttons[index];
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
                  // 소식 없음 화면을 클릭했을 때만 나타낼 내용
                  if (_currentText == "소식 없음 화면")
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.blueAccent.withOpacity(0.1),
                        child: const Text(
                          "여기에는 소식 관련 정보가 표시됩니다.",
                          style: TextStyle(
                            fontSize: 18,
                            color: SSU_BLACK,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
