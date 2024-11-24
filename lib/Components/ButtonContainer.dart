import 'dart:ffi';

import 'package:flutter/material.dart';
import './UtilityJH.dart';
import '../ConfigJH.dart';

class BlueButton extends StatefulWidget {
  final TextEditingController controller;
  final String hint_text;
  final BuildContext context;
  final String buttonName;
  final String type1;
  final String type2;
  final Function handler;

  const BlueButton(
      {super.key,
      required this.controller,
      required this.hint_text,
      required this.context,
      required this.buttonName,
      required this.type1,
      required this.type2,
      required this.handler});

  @override
  _BlueButtonState createState() => _BlueButtonState();
}

class _BlueButtonState extends State<BlueButton> {
  int isCheck = 0; // 초기 상태

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            grayInput(widget.controller, widget.hint_text, widget.context),
            Container(
              width: MediaQuery.of(context).size.width * 0.02,
            ), //margin
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.23,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  var flag = await widget.handler();
                  print(flag);

                  setState(() {
                    // 로직 추가
                    if (flag) {
                      isCheck = 2;
                    } else {
                      isCheck = 1;
                    }
                    //isCheck = (isCheck + 1) % 3;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(
                      color: SSU_BLACK, // 버튼 테두리 색상
                      width: 1.0, // 버튼 테두리 두께
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.buttonName,
                    style: const TextStyle(
                        fontSize: 13, // 텍스트 크기
                        color: SSU_BLACK),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isCheck == 1)
          SizedBox(
              height: 30,
              child: Text(
                widget.type1,
                style: const TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ))
        else if (isCheck == 2)
          SizedBox(
            height: 30,
            child: Text(
              widget.type2,
              style: const TextStyle(
                  fontSize: 11,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          )
        else
          Container(
            height: 20,
          )
      ],
    );
  }
}

class BlueButtonEmail extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller_check;
  final String hint_text;
  final String hint_text_code;
  final BuildContext context;
  final String buttonName;
  final String buttonName_code;
  final String type1;
  final String type2;
  final String type3;
  final Function handler;
  final Function send_handler;

  const BlueButtonEmail(
      {super.key,
      required this.controller,
      required this.controller_check,
      required this.hint_text,
      required this.hint_text_code,
      required this.context,
      required this.buttonName,
      required this.buttonName_code,
      required this.type1,
      required this.type2,
      required this.type3,
      required this.handler,
      required this.send_handler});

  @override
  _BlueButtonEmailState createState() => _BlueButtonEmailState();
}

class _BlueButtonEmailState extends State<BlueButtonEmail> {
  int closed = 0; // 초기 상태

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            grayInput(widget.controller, widget.hint_text, widget.context),
            Container(
              width: MediaQuery.of(context).size.width * 0.02,
            ), //margin
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.23,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  var flag = await widget.handler();

                  setState(() {
                    // 로직 추가
                    closed = flag;
                    //isCheck = (isCheck + 1) % 3;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(
                      color: SSU_BLACK, // 버튼 테두리 색상
                      width: 1.0, // 버튼 테두리 두께
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.buttonName,
                    style: const TextStyle(
                        fontSize: 13, // 텍스트 크기
                        color: SSU_BLACK),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (closed == 1)
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: BlueButton(
                  controller: widget.controller_check,
                  hint_text: widget.hint_text_code,
                  context: widget.context,
                  buttonName: widget.buttonName_code,
                  type1: widget.type1,
                  type2: widget.type2,
                  handler: widget.send_handler))
        else if (closed == 2)
          SizedBox(
              height: 30,
              child: Text(
                widget.type3,
                style: const TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ))
        else
          Container(
            height: 20,
          )
      ],
    );
  }
}
