import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/Controllers/calander_controller.dart';
import 'package:scheduler/Models/tag.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("할 일 추가"),

        // titleTextStyle: const TextStyle(
        //   fontWeight: FontWeight.normal,
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) {
                _enteredTitle = value;
                setState(() {});
              },
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: "할 일",
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
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
                  ), // 포커스 상태에서 테두리 색상
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              onChanged: (value) {
                _enteredContent = value;
                setState(
                  () {},
                );
              },
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: "내용",
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(color: Colors.grey), // 비활성화 상태의 테두리 색상
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        const BorderSide(color: Colors.grey) // 활성화 상태의 테두리 색상
                    ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ), // 포커스 상태에서 테두리 색상
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: () {
                  calanderCont.addTag(calanderCont.year, calanderCont.month,
                      widget.day, _enteredTitle, _enteredContent);
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
    );
  }
}
