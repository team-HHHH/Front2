import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scheduler/Components/ApiHelper.dart';

import 'package:get/get.dart';
import 'package:scheduler/Components/Reissue.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/token_controller.dart';

class UserinfoController extends GetxController {
  final TokenController tokenController = Get.put(TokenController());

  var nickname = "로딩 중 ... ";
  var loginId = "로딩 중 ... ";
  var address = "로딩 중 ... ";
  var email = "로딩 중 ... ";
  var profileImg = "로딩 중 ... ";

  Future<void> getUserInfo() async {
    print(tokenController.accessToken);
    final url = Uri.http(SERVER_DOMAIN, "users");
    final response = await ssuGet(url, headers: {
      'Content-Type': 'application/json',
      "Authorization": tokenController.accessToken.toString(),
    });
    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();
    print(resultMessage);
    if (resultCode != 200) return;

    nickname = responseData.getBodyValueOne("nickname").toString();
    loginId = responseData.getBodyValueOne("loginId").toString();
    address = responseData.getBodyValueOne("address").toString();
    email = responseData.getBodyValueOne("email").toString();
    profileImg = responseData.getBodyValueOne("profileImg").toString();

    print(nickname + " : " + address + ", id=" + loginId);
  }
}
