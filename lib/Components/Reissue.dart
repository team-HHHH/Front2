import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:scheduler/Components/ApiHelper.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/token_controller.dart';

Future<http.Response> ssuPost(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  final TokenController tokenController = Get.put(TokenController());
  final response = await http.post(url, headers: headers, body: body);

  ApiHelper apiHelper = ApiHelper(response.body);
  final return_code = apiHelper.getResultCode();
  if (return_code == 401) {
    print(tokenController.refreshToken.toString());
    final reIssueResponse = await http.post(
        Uri.http(SERVER_DOMAIN, "users/reissue"),
        headers: {"refresh": tokenController.refreshToken.toString()});

    print("reissue 필요 : " + reIssueResponse.body);
  }
  return response;
}
