import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/calander_controller.dart';
import 'package:scheduler/Models/tag.dart';
import 'package:table_calendar/table_calendar.dart';

class CalanderAddScreen extends StatefulWidget {
  const CalanderAddScreen({super.key, required this.day});
  final int day;

  @override
  State<CalanderAddScreen> createState() => _CalanderAddScreenState();
}

class _CalanderAddScreenState extends State<CalanderAddScreen> {
  final calanderCont = Get.put(CalanderController());

  String _enteredTitle = "";
  String _enteredContent = "";
  DateTime? _selectedDate;
  DateTime? _focusedDate;

  // FocusNodes for text fields
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();

  // ScrollController for scrolling
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(calanderCont.year, calanderCont.month, widget.day);
  }

  // Function to scroll to a focused text field
  void _scrollToFocus(FocusNode focusNode) {
    if (focusNode.hasFocus) {
      _scrollController.animateTo(
        200.0, // adjust this value based on your layout
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "할 일 추가",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          controller: _scrollController, // Attach scroll controller
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TableCalendar(
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
                focusedDay: _selectedDate ?? DateTime.now(),
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
                        focusNode: _titleFocusNode,
                        onChanged: (value) {
                          _enteredTitle = value;
                          setState(() {});
                        },
                        onEditingComplete: () {
                          // Move focus to the next field
                          _titleFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(_contentFocusNode);
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "할 일",
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
                        focusNode: _contentFocusNode,
                        onChanged: (value) {
                          _enteredContent = value;
                          setState(() {});
                        },
                        onEditingComplete: () {
                          // Close keyboard and move to the button
                          _contentFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          hintText: "내용",
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
                    if (_focusedDate == null) {
                      calanderCont.addTag(calanderCont.year, calanderCont.month,
                          widget.day, _enteredTitle, _enteredContent);
                    } else {
                      final year = _focusedDate!.year;
                      final month = _focusedDate!.month;
                      final day = _focusedDate!.day;
                      calanderCont.addTag(
                          year, month, day, _enteredTitle, _enteredContent);
                    }

                    Get.back();
                  },
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "생성하기",
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
