import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:get/get.dart';
import 'package:scheduler/Screens/camera_screen.dart';
import 'package:scheduler/Screens/register_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CameraScreen());
            },
            icon: const Icon(Icons.camera_alt_outlined),
          )
        ],
      ),
    );
  }
}
