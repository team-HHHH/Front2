import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_story.dart';
import 'package:scheduler/Screens/calander_screen.dart';
import 'package:scheduler/Screens/login_screen.dart';
import 'package:scheduler/Screens/main_screen.dart';
import 'package:scheduler/Screens/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '1e183dbd3fe27b83dd4f6c01898a258f',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 96, 193, 195),
        useMaterial3: true,
      ),
      //home: const CalanderScreen(),
      //home: const MainScreen(),
      home: LoginScreen(),
      //home: ProfileScreen(),
      //home: const ProfileScreen(),
      //home: const ProfileEditScreen(),
      //home: const PasswordEditScreen(),
    );
  }
}
