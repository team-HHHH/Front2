import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scheduler/Components/ApiHelper.dart';

import 'package:get/get.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/token_controller.dart';
import 'package:scheduler/Screens/login_screen.dart';

class LogoutController extends GetxController {
  final TokenController tokenController = Get.put(TokenController());

  void logout() {
    tokenController.setAccessToken("");
    tokenController.setRefreshToken("");
    Get.to(LoginScreen());
  }

  void run() {
    tokenController.setAccessToken("");
    tokenController.setRefreshToken("");
    Get.to(LoginScreen());
  }
}
