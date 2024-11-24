import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/Components/KakaoMapService.dart';
import 'package:scheduler/Components/kakaoMap.dart';

import '../ConfigJH.dart';

// Custom GestureDetector with Row
Widget profileNaviBar(String text, dynamic gotos) {
  return GestureDetector(
    onTap: () {
      Get.to(gotos);
    },
    child: Container(
      width: double.infinity, // 화면 가로 길이 전체
      height: 35, // 버튼 높이
      color: Colors.transparent, // 버튼 배경색 없음
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: GRAY,
            size: 14,
          )
        ],
      ),
    ),
  );
}

// Custom Divider
Widget dividerBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(1.0), // 구분선의 두께
    child: Divider(
      thickness: 1.0,
      height: 1.0,
      color: Colors.grey.shade300, // 구분선 색상
    ),
  );
}

AppBar topBar(String text, String gotoUrl) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0), // 구분선의 두께
      child: Divider(
        thickness: 1.0,
        height: 1.0,
        color: Colors.grey.shade300, // 구분선 색상
      ),
    ),
    leading: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(
              color: SSU_BLUE,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    actions: <Widget>[
      IconButton(
          onPressed: () {
            debugPrint(gotoUrl);
          },
          icon: const Icon(Icons.search, color: SSU_BLUE)),
      const SizedBox(width: 14),
    ],
  );
}

AppBar topBarDefault(String text, String buttonName, dynamic page) {
  print("클릭됨");
  return AppBar(
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0), // 구분선의 두께
        child: Divider(
          thickness: 1.0,
          height: 1.0,
          color: Colors.grey.shade300, // 구분선 색상
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 20,
          color: SSU_BLACK,
        ),
      ),
      title: Text(text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          )),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Get.to(page);
            },
            child: Text(
              buttonName,
              style: const TextStyle(
                color: SSU_BLACK,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            )),
      ]);
}

Widget keyValueText(String key, String value) {
  return SizedBox(
    height: 30,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        key,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      )
    ]),
  );
}

Widget grayTextButton(String name, dynamic func) {
  return SizedBox(
    height: 35,
    child: TextButton(
      onPressed: () {
        func.run();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12, // 폰트 크기
          color: SSU_BLACK, // 텍스트 색상
        ),
      ),
    ),
  );
}

Widget grayInputLong(TextEditingController controller, String hintText,
    BuildContext context, bool passwd) {
  return SizedBox(
      //width: double.infinity,
      width: MediaQuery.of(context).size.width * 0.9,
      height: 40,
      child: TextFormField(
          obscureText: passwd,
          controller: controller,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
              hintText: hintText,
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
              ))));
}

Widget grayInputLongWithSearch(
    TextEditingController controller, String hintText, BuildContext context) {
  return SizedBox(
      //width: double.infinity,
      width: MediaQuery.of(context).size.width * 0.9,
      height: 40,
      child: TextFormField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
              hintText: hintText,
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
              suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: SSU_BLACK,
                  ),
                  onPressed: () async {
                    debugPrint("web view");

                    final coordinates =
                        await getCoordinatesFromAddress("서울 특별시");
                    if (coordinates != null) {
                      double latitude =
                          coordinates['latitude']!; // Map에서 위도 가져오기
                      double longitude =
                          coordinates['longitude']!; // Map에서 경도 가져오기

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KakaoMapPage(
                              /*
                            latitude: latitude,
                            longitude: longitude,
                            */
                              ),
                        ),
                      );
                    }
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KakaoMapPage()),
                    );
                    */
                    //showAddressSearchDialog(context);
                  }))));
}

Widget grayInput(
    TextEditingController controller, String hintText, BuildContext context) {
  return SizedBox(
      //width: double.infinity,
      width: MediaQuery.of(context).size.width * 0.6,
      height: 40,
      child: TextFormField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
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
          )));
}
