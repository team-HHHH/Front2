import 'dart:convert';
import 'dart:developer';
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height * 0.8;
    double itemWidth = screenWidth / 8; // 너비를 화면의 1/8로 설정
    double dayHeight = screenHeight / 10;
    double WeekHeight = dayHeight / 3;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                print("카메라 버튼 터치!");
                calanderCont.summerizePosterUrgen(context);
                /*
                Get.to(() => const CameraScreen(),
                    transition: Transition.cupertino);
                */
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: SSU_BLUE,
              ),
            )
          ],
          title: const Text(
            "Calander",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.arrow_left, size: 30),
                                color: SSU_BLUE,
                                onPressed: () {
                                  calanderCont.monthDown();
                                  chgDate(
                                      calanderCont.year, calanderCont.month);
                                }),
                            Text(
                              "${calanderCont.year.toString()}년 ${calanderCont.month.toString()}월",
                              style: const TextStyle(
                                fontSize: 16,
                                color: CALANDER_TEXT_GRAY,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_right, size: 30),
                              color: SSU_BLUE,
                              onPressed: () {
                                calanderCont.monthUp();
                                chgDate(calanderCont.year, calanderCont.month);
                              },
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
                        width: itemWidth,
                        height: WeekHeight,
                        decoration: BoxDecoration(
                          border: Border.all(color: BORDER_GRAY, width: 0.2),
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
                                        : CALANDER_TEXT_GRAY,
                                fontSize: 10,
                                fontWeight: FontWeight.bold), // 텍스트 스타일 정의
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
                          // 달력 터치 이벤트
                          onTap: () {
                            onDayTap(calanderCont.year, calanderCont.month,
                                calanderCont.viewDays[row][col]);
                          },
                          child: Container(
                            width: itemWidth,
                            height: dayHeight,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: BORDER_GRAY, width: 0.2),
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
                                                : CALANDER_TEXT_GRAY,
                                        fontSize: 12,
                                        fontWeight:
                                            FontWeight.bold), // 텍스트 스타일 정의
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            SizedBox(
                                height: 350,
                                child: CalanderAddScreen(day: _selectedDay)),
                            enableDrag: true,
                            isDismissible: true,
                          );
                        },
                        iconSize: 30,
                        icon: const Icon(Icons.add, color: SSU_BLUE),
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
                        Color color;
                        if (tag.tag == 1) {
                          color = Colors.blue;
                        } else if (tag.tag == 2) {
                          color = Colors.yellow;
                        } else if (tag.tag == 3) {
                          color = Colors.green;
                        } else if (tag.tag == 4) {
                          color = Colors.black;
                        } else {
                          color = Colors.red;
                        }
                        return ListTile(
                          leading: Icon(
                            Icons.event,
                            color: color,
                          ),
                          title: Text(tag.title),
                          subtitle: Text(tag.content),
                          onTap: () {
                            Get.bottomSheet(
                              SizedBox(
                                height: 350,
                                child: CalanderDetailScreen(tagNode: tag),
                              ),
                              isDismissible: true,
                              enableDrag: true,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
