import 'package:flutter/material.dart';

List<Color> BLUE_TAG = const [
  Color.fromRGBO(0, 133, 255, 0.1),
  Color.fromRGBO(0, 133, 255, 0.1),
  Colors.blue,
];
List<Color> YELLOW_TAG = const [
  Color.fromRGBO(255, 150, 27, 0.1),
  Color.fromRGBO(255, 150, 27, 0.1),
  Colors.orange,
];
List<Color> GREEN_TAG = const [
  Color.fromRGBO(0, 186, 52, 0.1),
  Color.fromRGBO(0, 186, 52, 0.1),
  Colors.green,
];
List<Color> BLACK_TAG = const [
  Color(0xFFE8E8E8),
  Color(0xFFE8E8E8),
  Colors.black,
];
List<Color> RED_TAG = const [
  Color.fromRGBO(255, 59, 59, 0.1),
  Color.fromRGBO(255, 59, 59, 0.1),
  Colors.red,
];

Container tags(List<Color> color, String text, double width, double height) {
  double tagHeight = height / 6.5;
  return Container(
    width: width,
    height: tagHeight,
    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    margin: EdgeInsets.fromLTRB(0, 0, 0, tagHeight / 5),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color[0],
          color[1],
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      color: Colors.white, // 기본 배경색
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            text,
            style: TextStyle(
                color: color[2], fontSize: 10, fontWeight: FontWeight.bold),
            softWrap: true, // 자동 줄바꿈 활성화
            overflow: TextOverflow.ellipsis, // 넘칠 경우 ...으로 표시
          ),
        ),
      ],
    ),
  );
}

Container BlueTag(String text, double width, double height) {
  return tags(BLUE_TAG, text, width, height);
}

Container YellowTag(String text, double width, double height) {
  return tags(YELLOW_TAG, text, width, height);
}

Container GreenTag(String text, double width, double height) {
  return tags(GREEN_TAG, text, width, height);
}

Container BlackTag(String text, double width, double height) {
  return tags(BLACK_TAG, text, width, height);
}

Container RedTag(String text, double width, double height) {
  return tags(RED_TAG, text, width, height);
}
