import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/register_controller.dart';
import 'package:scheduler/Controllers/token_controller.dart';
import 'package:scheduler/Screens/register_detail_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController());
  var _isChecked1 = false;
  var _isChecked2 = false;
  var _isChecked3 = false;
  var _isChecked4 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: TextButton(
            onPressed: () {
              registerController.handleNext();
              Get.to(const RegisterDetailScreen());
            },
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: SSU_BLACK,
            ),
            child: const Text(
              "계속하기",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // 구분선의 두께
          child: Divider(
            thickness: 1.0,
            height: 1.0,
            color: Colors.grey.shade300, // 구분선 색상
          ),
        ),
        title: const Text(
          "회원가입",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "더욱 자세한 정보 제공을 위해",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "정보를 입력해주세요!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                "로그인 정보 입력",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            onChanged: (newValue) {
                              registerController.updateId(newValue);
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: "아이디를 입력하세요.",
                              contentPadding:
                                  const EdgeInsets.fromLTRB(15, 0, 0, 5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: Colors.grey), // 비활성화 상태의 테두리 색상
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: Colors.grey) // 활성화 상태의 테두리 색상
                                  ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: SSU_BLACK,
                                  width: 1.25,
                                ), // 포커스 상태에서 테두리 색상
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              //_formKey.currentState!.save();
                              registerController.handleCheckId();
                            },
                            style: TextButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              backgroundColor: SSU_BLACK,
                            ),
                            child: const Text(
                              "중복확인",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      registerController.getIdMessage(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      onChanged: (value) {
                        registerController.updatePassword(value);
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: "비밀번호를 입력하세요.",
                        contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: Colors.grey), // 비활성화 상태의 테두리 색상
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: Colors.grey) // 활성화 상태의 테두리 색상
                            ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: SSU_BLACK,
                            width: 1.25,
                          ), // 포커스 상태에서 테두리 색상
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      onChanged: (value) {
                        registerController.updatePassword2(value);
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: "비밀번호를 한번 더 입력하세요.",
                        contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: Colors.grey), // 비활성화 상태의 테두리 색상
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: Colors.grey) // 활성화 상태의 테두리 색상
                            ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: SSU_BLACK,
                            width: 1.25,
                          ), // 포커스 상태에서 테두리 색상
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      registerController.getPasswordMessage(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            onChanged: (value) {
                              registerController.updateEmail(value);
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: "이메일 주소를 입력하세요.",
                              contentPadding:
                                  const EdgeInsets.fromLTRB(15, 0, 0, 5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: Colors.grey), // 비활성화 상태의 테두리 색상
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: Colors.grey) // 활성화 상태의 테두리 색상
                                  ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: SSU_BLACK,
                                  width: 1.25,
                                ), // 포커스 상태에서 테두리 색상
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              registerController.handleCheckCode();
                            },
                            style: TextButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              backgroundColor: SSU_BLACK,
                            ),
                            child: const Text(
                              "인증하기",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  registerController.isReceivedCode.value
                      ? Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  onChanged: (value) {
                                    registerController.updateCode(value);
                                  },
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "6자리 코드를 입력하세요.",
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: const BorderSide(
                                          color:
                                              Colors.grey), // 비활성화 상태의 테두리 색상
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                            color:
                                                Colors.grey) // 활성화 상태의 테두리 색상
                                        ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1.25,
                                      ), // 포커스 상태에서 테두리 색상
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 40,
                                child: TextButton(
                                  onPressed: () {
                                    registerController.handleCheckCode();
                                  },
                                  style: TextButton.styleFrom(
                                    splashFactory: NoSplash.splashFactory,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  child: const Text(
                                    "인증",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "서비스 이용약관 동의",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "이용약관 전체 동의",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "[필수] 만 14세 이상입니다.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _isChecked1 ? SSU_BLACK : Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                    child: Checkbox(
                      value: _isChecked1,
                      checkColor: Colors.white,
                      hoverColor: SSU_GRAY,
                      activeColor: SSU_BLACK,
                      onChanged: (newValue) {
                        _isChecked1 = newValue!;
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "[필수] 이용약관 동의",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _isChecked2 ? SSU_BLACK : Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                    child: Checkbox(
                      checkColor: Colors.white,
                      hoverColor: SSU_GRAY,
                      activeColor: SSU_BLACK,
                      value: _isChecked2,
                      onChanged: (newValue) {
                        _isChecked2 = newValue!;
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "[필수] 개인정보 수집 및 이용 동의",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _isChecked3 ? SSU_BLACK : Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                    child: Checkbox(
                      value: _isChecked3,
                      checkColor: Colors.white,
                      hoverColor: SSU_GRAY,
                      activeColor: SSU_BLACK,
                      onChanged: (newValue) {
                        _isChecked3 = newValue!;
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "[선택] 광고성 정보 수신 / 마케팅 활용 동의",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _isChecked4 ? SSU_BLACK : Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                    child: Checkbox(
                      value: _isChecked4,
                      checkColor: Colors.white,
                      hoverColor: SSU_GRAY,
                      activeColor: SSU_BLACK,
                      onChanged: (newValue) {
                        _isChecked4 = newValue!;
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
