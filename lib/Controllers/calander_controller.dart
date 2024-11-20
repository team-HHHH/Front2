import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:scheduler/Components/ApiHelper.dart';
import 'package:scheduler/Components/Reissue.dart';
import 'package:scheduler/Components/calanderTags.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:http/http.dart' as http;
import 'package:scheduler/Controllers/token_controller.dart';
import 'package:scheduler/Models/tag.dart';

class CalanderController extends GetxController {
  final TokenController tokenController = Get.put(TokenController());

  var year = -1;
  var month = -1;
  var start = 0;
  var maxRow = 0;

  //Dummy Tag
  final RxMap<String, List<TagNode>> tagMap = <String, List<TagNode>>{}.obs;

  void setYear(int args) {
    year = args;
  }

  void setMonth(int args) {
    month = args;
  }

  CalanderController() {
    DateTime now = DateTime.now();
    year = now.year;
    month = now.month;
    fetchDataByDate(year, month);
  }

  List<List<int>> viewDays = [
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
  ];

  // //Tag 추가함수
  // void addTag(TagNode adder) {
  //   // API 단에서 adder.sid 받아와서 추가할 것 -> mySQL에서 호출 및 API 설정 //

  //   print(adder);

  //   DateTime dt = adder.timeDetail;
  //   String key = '${dt.year}-${dt.month}-${dt.day}';
  //   print(key);
  //   // 리스트가 비어 있으면 해당 키 삭제
  //   if (tagMap.containsKey(key)) {
  //     tagMap[key]!.add(adder);
  //   } else {
  //     tagMap[key] = [adder];
  //   }
  // }

  void addTag(
      int year, int month, int day, String title, String content) async {
    DateTime dateTime = DateTime(year, month, day);
    String stringTime = dateTime.toIso8601String();
    final url = Uri.http(SERVER_DOMAIN, "/calenders");
    final response = await ssuPost(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': tokenController.accessToken.toString(),
      },
      body: jsonEncode(
        {
          "dateInfo": {"year": year, "month": month, "day": day},
          "title": title,
          "content": content,
          "startDay": stringTime,
          "endDay": stringTime
        },
      ),
    );
    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    print(responseData.responseData);
    final resultCode = responseData.getResultCode();
    if (resultCode != 200) return;
    final sid = responseData.getBody();

    String key = '$year-$month-$day';
    print(key);
    TagNode adder = TagNode(
        title: title,
        content: content,
        timeDetail: dateTime,
        tag: (sid % 5) + 1,
        sid: sid);
    // 리스트가 비어 있으면 해당 키 삭제
    if (tagMap.containsKey(key)) {
      tagMap[key]!.add(adder);
    } else {
      tagMap[key] = [adder];
    }

    print("생성 완료");
  }

  //Tag삭제함수
  void removeTag(int year, int month, int day, int sid) async {
    final url = Uri.http(SERVER_DOMAIN, "/calenders/$sid");
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': ACCESS_TOKEN,
      },
    );
    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    print(responseData.responseData);
    final resultCode = responseData.getResultCode();
    if (resultCode != 200) return;

    String key = '$year-$month-$day';
    // 해당 날짜에 리스트가 있는지 확인
    if (tagMap.containsKey(key)) {
      tagMap[key]!.removeWhere((node) => node.sid == sid);

      if (tagMap[key]!.isEmpty) {
        tagMap.remove(key);
      }
      print("삭제완료");
    }
  }

  // void updateTag(int year, int month, int day, int sid) {
  //   String key = '$year-$month-$day';
  // }

  void summarizePoster(Uint8List poster) async {
    final url = Uri.http(SERVER_DOMAIN, "/posters/upload");
    final request = http.MultipartRequest('POST', url);

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': tokenController.accessToken.toString()
    });
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        poster,
        filename: 'image.png',
        contentType: MediaType('image', 'png'),
      ),
    );
    print(1);
    final response = await request.send();
    print(2);

    if (response.statusCode != 200) return;
    print(3);

    final responseBody = await response.stream.bytesToString();
    print(4);
    final responseData = ApiHelper(responseBody);

    final resultCode = responseData.getResultCode();
    print(resultCode);
    if (resultCode != 200) return;
    print(6);
    final title = responseData.getBodyValue("title").toString();
    final content = responseData.getBodyValue("content").toString();
    final startDay = responseData.getBodyValue('startDay').toString();
    final endDay = responseData.getBodyValue('endDay').toString();
    print(7);
    print(title);
    print(content);
    print(startDay);
    print(endDay);
  }

  List<TagNode> getTags(int year, int month, int day) {
    String key = '$year-$month-$day';

    if (tagMap.containsKey(key)) {
      return tagMap[key]!;
    } else {
      return [];
    }
  }

  //Calander 에 3개만 보여줄 Tag 리스트
  List<Container> retTagShortList(int day, double width, double height) {
    List<Container> li = [];
    String key = '$year-$month-$day';
    if (tagMap.containsKey(key)) {
      List<TagNode>? tagList = tagMap[key];
      if (tagList != null) {
        for (int i = 0; i < tagMap[key]!.length && i < 3; i++) {
          int tagInfo = tagList[i].tag;
          switch (tagInfo) {
            case 1:
              li.add(BlueTag(tagList[i].title, width, height));
              break;
            case 2:
              li.add(YellowTag(tagList[i].title, width, height));
              break;
            case 3:
              li.add(GreenTag(tagList[i].title, width, height));
              break;
            case 4:
              li.add(BlackTag(tagList[i].title, width, height));
              break;
            case 5:
              li.add(RedTag(tagList[i].title, width, height));
              break;
          }
        }
      }
    }

    return li;
  }

  void Dummy() {
    // print("dummy 추가");
    // TagNode blue = TagNode(
    //     title: "공모전A",
    //     content: "공모전이 좋습니다",
    //     timeDetail: DateTime(2024, 10, 5, 12),
    //     tag: 1,
    //     sid: 12);
    // TagNode yellow = TagNode(
    //     title: "시험B",
    //     content: "시험이 ㅈ 습니다",
    //     timeDetail: DateTime(2024, 10, 5, 12),
    //     tag: 2,
    //     sid: 12);
    // TagNode green = TagNode(
    //     title: "롤정글",
    //     content: "시험이 ㅈ 습니다",
    //     timeDetail: DateTime(2024, 10, 5, 12),
    //     tag: 3,
    //     sid: 12);
    // TagNode black = TagNode(
    //     title: "롤대남",
    //     content: "시험이 ㅈ 습니다",
    //     timeDetail: DateTime(2024, 10, 12, 14),
    //     tag: 4,
    //     sid: 12);
    // TagNode red = TagNode(
    //     title: "롤로노이",
    //     content: "시험이 ㅈ 습니다",
    //     timeDetail: DateTime(2024, 10, 20, 20),
    //     tag: 5,
    //     sid: 12);
    // TagNode red2 = TagNode(
    //     title: "롤로노이2",
    //     content: "시험이 ㅈ 습니다",
    //     timeDetail: DateTime(2024, 10, 20, 20),
    //     tag: 5,
    //     sid: 12);
    // TagNode red3 = TagNode(
    //     title: "결혼식?",
    //     content: "시험이 ㅈ 습니다",
    //     timeDetail: DateTime(2024, 11, 9, 20),
    //     tag: 5,
    //     sid: 12);

    // addTag(blue);
    // addTag(red);
    // addTag(red2);
    // addTag(green);
    // addTag(yellow);
    // addTag(black);
    // addTag(red3);
  }

  //캘린더 데이터 fetch 함수.
  // 향후, 캘린더 조회 API 완성 시 구현 마무리.
  void fetchData() async {
    final url = Uri.http(SERVER_DOMAIN, "/calanders");
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': tokenController.accessToken.toString()
      },
    );
    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();

    if (resultCode != 200) return;
  }

  // 캘린더 데이터 fetch 함수.
  // 년, 월을 기준으로 불러옴.
  void fetchDataByDate(int year, int month) async {
    // 쿼리 파라미터 추가
    final Uri url =
        Uri.parse("http://$SERVER_DOMAIN/calenders").replace(queryParameters: {
      'year': year.toString(),
      'month': month.toString(),
    });

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': tokenController.accessToken.toString(),
    });
    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    if (resultCode != 200) return;

    final tagNodes = responseData.getBody();
    List<TagNode> list = List<TagNode>.from(
        (tagNodes as List).map((item) => TagNode.fromJson(item)));

    tagMap.clear();
    for (final tagNode in list) {
      final year = tagNode.timeDetail.year;
      final month = tagNode.timeDetail.month;
      final day = tagNode.timeDetail.day;
      final title = tagNode.title;
      final content = tagNode.content;

      addTag(year, month, day, title, content);
    }
    print("조회 성공");
  }

  void monthDown() {
    if (month == 1) {
      year--;
    }
    month--;
    if (month == 0) {
      month = 12;
    }
    fetchDataByDate(year, month);
  }

  void monthUp() {
    if (month == 12) {
      year++;
    }
    month++;
    if (month == 13) {
      month = 1;
    }
    fetchDataByDate(year, month);
  }

  void calCalender(int y, int m) {
    year = y;
    month = m;
    DateTime date = DateTime(year, month, 1);
    start = date.weekday % 7;
    int lastDay = 0;

    if (month == 2) {
      // 윤년인지 확인
      bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      lastDay = isLeapYear ? 29 : 28;
    } else {
      // 30일과 31일인 경우
      lastDay = [1, 3, 5, 7, 8, 10, 12].contains(month) ? 31 : 30;
    }

    int row = 0, col = start;

    for (int i = 0; i < viewDays.length; i++) {
      for (int j = 0; j < viewDays[i].length; j++) {
        viewDays[i][j] = 0;
      }
    }

    for (int i = 1; i <= lastDay; i++) {
      viewDays[row][col] = i;
      col++;
      if (col == 7) {
        col = 0;
        row++;
      }
    }

    maxRow = col != 0 ? row + 1 : row;
  }
}
