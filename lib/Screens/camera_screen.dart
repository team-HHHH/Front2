import 'dart:typed_data';
import 'dart:ui'; // BackdropFilter를 사용하기 위해 추가

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:get/get.dart';
import 'package:scheduler/Components/Alert.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/calander_controller.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final _controller = DocumentScannerController();
  final calanderController = CalanderController();

  var isTaked = false;
  var isCropped = false;
  Uint8List? imageData;

  void showCustomCupertinoDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("알림", textAlign: TextAlign.center),
          content: Column(
            children: [
              const SizedBox(height: 10),
              Image.memory(
                imageData!,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              const Text("포스터를 요약할까요?")
            ],
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "취소",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                calanderController.summarizePoster(imageData!);
                Navigator.of(context).pop();
              },
              child: const Text(
                "요약",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: DocumentScanner(
              controller: _controller,
              onSave: (Uint8List imageBytes) {
                print(111111111111111);
              },
              takePhotoDocumentStyle: const TakePhotoDocumentStyle(
                top: 60,
                bottom: 60,
                left: 60,
                right: 60,
                hideDefaultButtonTakePicture: true,
              ),
              cropPhotoDocumentStyle: const CropPhotoDocumentStyle(
                  textButtonSave: "자르기", hideAppBarDefault: true),
              generalStyles: const GeneralStyles(
                hideDefaultDialogs: true,
                baseColor: Colors.black,
                hideDefaultBottomNavigation: true,
              ),
              editPhotoDocumentStyle: const EditPhotoDocumentStyle(
                hideAppBarDefault: true,
                hideBottomBarDefault: true,
                textButtonSave: "저장",
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    size: 60,
                    Icons.circle_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    if (!isTaked) {
                      await _controller.takePhoto();
                      await _controller.changePage(AppPages.cropPhoto);
                      isTaked = true;
                      setState(() {});
                    } else if (!isCropped) {
                      await _controller.cropPhoto();
                      await _controller.changePage(AppPages.editDocument);
                      isCropped = true;
                      setState(() {});
                    } else {
                      imageData = _controller.pictureCropped;
                      setState(() {});
                      Get.back();
                      showCustomCupertinoDialog(context);
                    }
                  },
                ),
                Text(
                  isTaked ? (isCropped ? "확인" : "편집") : "촬영",
                  style: const TextStyle(
                    color: SSU_BLUE,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
