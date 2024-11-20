import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/calander_controller.dart';
import 'package:scheduler/Models/tag.dart';

class CalanderDetailScreen extends StatelessWidget {
  CalanderDetailScreen({super.key, required this.tagNode});
  final TagNode tagNode;
  final calanderCont = Get.put(CalanderController());

  void _showDeleteDialog(BuildContext context) {
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
                // 삭제 로직 추가
                calanderCont.removeTag(
                    tagNode.timeDetail.year,
                    tagNode.timeDetail.month,
                    tagNode.timeDetail.day,
                    tagNode.sid); // 해당 태그 삭제
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

  void _showEditDialog(BuildContext context) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteDialog(context); // 삭제 다이얼로그 표시
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) {},
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: tagNode.title,
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
              onChanged: (value) {},
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: tagNode.content,
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
                  _showEditDialog(context); // 수정 다이얼로그 표시
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
    );
  }
}
