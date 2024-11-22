import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/calander_controller.dart';
import 'package:scheduler/Models/tag.dart';
import 'package:table_calendar/table_calendar.dart';

class CalanderDetailScreen extends StatefulWidget {
  const CalanderDetailScreen({super.key, required this.tagNode});
  final TagNode tagNode;

  @override
  State<CalanderDetailScreen> createState() => _CalanderDetailScreenState();
}

class _CalanderDetailScreenState extends State<CalanderDetailScreen> {
  final calanderCont = Get.put(CalanderController());
  DateTime? _selectedDate;
  DateTime? _focusedDate;

  void _showDeleteDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('삭제 확인'),
          content: const Text('삭제하시겠습니까?'),
          actions: [
            CupertinoDialogAction(
              textStyle: const TextStyle(color: Colors.black),
              onPressed: () {
                Get.back(); // 대화상자 닫기
              },
              child: const Text('아니오'),
            ),
            CupertinoDialogAction(
              textStyle: const TextStyle(
                color: Colors.red,
              ),
              onPressed: () {
                final year = _focusedDate!.year;
                final month = _focusedDate!.month;
                final day = _focusedDate!.day;

                calanderCont.removeTag(
                    year, month, day, widget.tagNode.sid); // 해당 태그 삭제
                Get.back(); // 대화상자 닫기
                Get.back(); // 상세 화면 닫기
              },
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, String title, String content,
      DateTime? selectTime) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('수정 확인'),
          content: const Text('수정하시겠습니까?'),
          actions: [
            CupertinoDialogAction(
              textStyle: const TextStyle(
                color: Colors.black,
              ),
              onPressed: () {
                Get.back(); // 대화상자 닫기
              },
              child: const Text('아니오'),
            ),
            CupertinoDialogAction(
              textStyle: const TextStyle(
                color: Colors.red,
              ),
              onPressed: () {
                // 수정 로직 추가해야함.
                calanderCont.updateTag(
                    widget.tagNode, title, content, selectTime);

                Get.back(); // 대화상자 닫기
                Get.back(); // 상세 화면 닫기
              },
              child: const Text('수정'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusedDate = DateTime(widget.tagNode.timeDetail.year,
        widget.tagNode.timeDetail.month, widget.tagNode.timeDetail.day);
  }

  @override
  Widget build(BuildContext context) {
    String chgTitle = "", chgContent = "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteDialog(); // 삭제 다이얼로그 표시
            },
          ),
        ],
        centerTitle: true,
        title: const Text(
          "편집",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          // controller: _scrollController, // Attach scroll controller
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TableCalendar(
                currentDay: _focusedDate,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronVisible: true,
                  rightChevronVisible: true,
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: SSU_BLUE, // 선택된 날짜 색상
                    shape: BoxShape.circle,
                  ),
                  // 기본 날짜 스타일 (선택되지 않은 날짜)
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                ),
                focusedDay: DateTime(
                    widget.tagNode.timeDetail.year,
                    widget.tagNode.timeDetail.month,
                    widget.tagNode.timeDetail.day),
                firstDay:
                    DateTime.now().subtract(const Duration(days: 365 * 10)),
                lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
                locale: 'ko_KR',
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay; // 선택한 날짜 업데이트
                    _focusedDate = focusedDay; // 포커스 날짜 업데이트
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDate, day); // 선택된 날짜만 표시
                },
                eventLoader: (day) {
                  if (isSameDay(day, _selectedDate)) {
                    return [SSU_BLUE]; // 선택된 날짜에만 마커
                  }
                  return [];
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Icon(
                    Icons.discount,
                    size: 20,
                    color: SSU_BLUE,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          chgTitle = value;
                        },
                        decoration: InputDecoration(
                          hintText: widget.tagNode.title,
                          contentPadding:
                              const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.edit_document, color: SSU_BLUE, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        onChanged: (value) {
                          chgContent = value;
                        },
                        decoration: InputDecoration(
                          hintText: widget.tagNode.content,
                          contentPadding:
                              const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 100,
                child: TextButton(
                  onPressed: () {
                    print("수정 전 --> ${_selectedDate.toString()}");
                    _showEditDialog(context, chgTitle, chgContent,
                        _selectedDate); // 수정 다이얼로그 표시
                    //_showEditDialog();
                  },
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "수정하기",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
