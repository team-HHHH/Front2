import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Screens/calander_screen.dart';
import 'package:scheduler/Screens/post_list_screen.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.compass), label: '둘러보기'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell), label: '알림'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: 'MY')
        ],
        activeColor: SSU_BLACK, // 선택된 탭 색상
        inactiveColor: CupertinoColors.systemGrey, // 비선택 탭 색상
        backgroundColor: Colors.white, // 배경색
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => const CalanderScreen(),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => const PosterListScreen(),
            );
          case 2:
            return CupertinoTabView(
              builder: (context) => const Center(child: Text('Settings Tab')),
            );
          default:
            return Container();
        }
      },
    );
  }
}
