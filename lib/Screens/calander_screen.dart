import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:scheduler/Components/ButtonContainer.dart';
import 'package:scheduler/Components/calanderTags.dart';
import 'package:scheduler/Controllers/calander_controller.dart';
import 'package:scheduler/Models/tag.dart';
import 'package:scheduler/Screens/calander_add_screen.dart';
import 'package:scheduler/Screens/calander_detail_screen.dart';
import 'package:scheduler/Screens/camera_screen.dart';
import 'package:scheduler/Screens/profile_screen.dart';

import '../ConfigJH.dart';
import '../Components/UtilityJH.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CalanderScreen extends StatefulWidget {
  const CalanderScreen({super.key});

  @override
  State<CalanderScreen> createState() => _CalanderScreenState();
}

class _CalanderScreenState extends State<CalanderScreen> {
  final List<String> weekdays = ["일", "월", "화", "수", "목", "금", "토"];
  final calanderCont = Get.put(CalanderController());
  int _selectedDay = 0;
  List<int> randomNumber = [1, 5, 2];
  List<TagNode> selectedTags = [];

  List<List<int>> viewDays = [
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
  ];

  @override
  void initState() {
    super.initState();
    // calanderCont.fetchData();

    calanderCont.calCalender(calanderCont.year, calanderCont.month);
    setState(() {
      viewDays = calanderCont.viewDays;
    });
  }

  void chgDate(int year, int month) {
    print("chgDate\n");
    calanderCont.calCalender(year, month);

    setState(() {
      year = calanderCont.year;
      month = calanderCont.month;
      viewDays = calanderCont.viewDays;
    });
  }

  void onDayTap(int year, int month, int day) {
    setState(() {
      _selectedDay = day;
      selectedTags = calanderCont.getTags(year, month, day);
    });
  }

  void makeRandomNumber() {
    final random = Random(); // Random 클래스 생성
    int r1 = random.nextInt(6); // 0부터 5까지의 정수 생성
    int r2 = random.nextInt(6);
    int r3 = random.nextInt(6);

    randomNumber[0] = r1;
    randomNumber[1] = r2;
    randomNumber[2] = r3;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height * 0.8;
    double itemWidth = screenWidth / 8; // 너비를 화면의 1/8로 설정
    double dayHeight = screenHeight / 10;
    double WeekHeight = dayHeight / 3;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 100,
          leading: Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: const Text(
              "슈:\n케쥴러",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: SSU_BLACK),
              maxLines: 2,
            ),
          ),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          actions: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 20),
              child: const Icon(
                Icons.near_me_outlined,
                color: SSU_BLACK,
                size: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: const Icon(
                Icons.access_time_outlined,
                color: SSU_BLACK,
                size: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: IconButton(
                onPressed: () {
                  calanderCont.summerizePosterUrgen(context);
                  Get.to(() => const CameraScreen(),
                      transition: Transition.cupertino);
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: SSU_BLACK,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 2024년10월 V + part///
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${calanderCont.year.toString()}년 ${calanderCont.month.toString()}월",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: CALANDER_TEXT_GRAY,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(
                                    Icons.event,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    "${randomNumber[0]}",
                                    style: const TextStyle(
                                      color: SSU_BLACK,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 2, 3),
                                    child: Icon(
                                      Icons.access_alarms_rounded,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    "${randomNumber[1]}",
                                    style: const TextStyle(
                                      color: SSU_BLACK,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 1, 2),
                                    child: Icon(
                                      Icons.check,
                                      size: 16,
                                      color: SSU_BLACK,
                                    ),
                                  ),
                                  Text(
                                    "${randomNumber[2]}",
                                    style: const TextStyle(
                                      color: SSU_BLACK,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_left, size: 24),
                                  color: SSU_BLACK,
                                  onPressed: () {
                                    makeRandomNumber();
                                    calanderCont.monthDown();
                                    chgDate(
                                      calanderCont.year,
                                      calanderCont.month,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_right, size: 24),
                                  color: SSU_BLACK,
                                  onPressed: () {
                                    makeRandomNumber();
                                    calanderCont.monthUp();
                                    chgDate(
                                      calanderCont.year,
                                      calanderCont.month,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 20, //마진
                ),
                // 달력 {월, 화, 수, 목, 금, 토, 일} 부분..
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List<Widget>.generate(
                      weekdays.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: itemWidth,
                        height: WeekHeight,
                        decoration: BoxDecoration(
                          // border: Border.all(color: BORDER_GRAY, width: 0.2),
                          borderRadius: index == 0
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                )
                              : index == 6
                                  ? const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                    )
                                  : null,
                        ),
                        child: Center(
                          // 텍스트 중앙 정렬
                          child: Text(
                            weekdays[index], // weekdays 리스트에서 해당 index의 값을 가져옴
                            style: TextStyle(
                                color: index == 0
                                    ? RED
                                    : index == 6
                                        ? SSU_BLUE
                                        : SSU_BLACK,
                                fontSize: 10,
                                fontWeight: FontWeight.w600), // 텍스트 스타일 정의
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                /////////////////////진짜 달력 부분 ////////////////////
                ...List<Widget>.generate(
                  calanderCont.maxRow,
                  //calanderCont.viewDays.length,
                  (row) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List<Widget>.generate(
                        calanderCont.viewDays[row].length,
                        (col) => InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          // 달력 터치 이벤트
                          onTap: () {
                            onDayTap(calanderCont.year, calanderCont.month,
                                calanderCont.viewDays[row][col]);
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(2, 2, 2, 0),
                                width: itemWidth,
                                height: dayHeight,
                                decoration: BoxDecoration(
                                  color: calanderCont.viewDays[row][col] == 0
                                      ? Colors.white
                                      : _selectedDay ==
                                              calanderCont.viewDays[row][col]
                                          ? SSU_BLACK
                                          : SSU_GRAY,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        "${calanderCont.viewDays[row][col] == 0 ? "" : calanderCont.viewDays[row][col]}",
                                        style: TextStyle(
                                          color: col == 0
                                              ? RED
                                              : col == 6
                                                  ? SSU_BLUE
                                                  : _selectedDay ==
                                                          calanderCont
                                                                  .viewDays[row]
                                                              [col]
                                                      ? Colors.white
                                                      : SSU_BLACK,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ), // 텍스트 스타일 정의
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ...calanderCont.retTagShortList(
                                              calanderCont.viewDays[row][col],
                                              itemWidth,
                                              dayHeight * 1.4),
                                          /*
                                              BlueTag("공모전", itemWidth, dayHeight),
                                              GreenTag("공모전이 왔어요 왔어요", itemWidth,
                                                  dayHeight),
                                              RedTag("긴급일정", itemWidth, dayHeight),
                                              */
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: itemWidth, height: 5),
                              Container(
                                width: itemWidth,
                                height: 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: calanderCont.viewDays[row][col] == 0
                                      ? Colors.white
                                      : _selectedDay ==
                                              calanderCont.viewDays[row][col]
                                          ? SSU_BLACK
                                          : Colors.white,
                                ),
                              ),
                              SizedBox(width: itemWidth, height: 5),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                      child: Text(
                        _selectedDay != 0
                            ? "${calanderCont.year}년 ${calanderCont.month}월 $_selectedDay일"
                            : "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _selectedDay == 0
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              onPressed: () {
                                Get.to(
                                  CalanderAddScreen(day: _selectedDay),
                                );
                              },
                              iconSize: 30,
                              icon: const Icon(Icons.add, color: SSU_BLACK),
                            ),
                          ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: selectedTags
                          .length, // 리스트 아이템 수. 실제 데이터 개수에 맞춰 설정하세요.
                      itemBuilder: (context, index) {
                        final tag = selectedTags[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5), // 리스트 아이템 간의 간격
                          decoration: BoxDecoration(
                            color: Colors.white, // 배경색
                            borderRadius: BorderRadius.circular(10), // 모서리 둥글기
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 그림자 색상
                                offset: const Offset(0, 2), // 그림자의 위치
                                blurRadius: 1, // 그림자 확산 정도
                              ),
                            ],
                          ),
                          child: ListTile(
                            // ListTile의 패딩
                            leading: const Icon(
                              size: 18,
                              Icons.event,
                              color: SSU_BLACK,
                            ),
                            title: Text(
                              tag.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            subtitle: Text(
                              tag.content,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            onTap: () {
                              Get.to(CalanderDetailScreen(tagNode: tag));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
