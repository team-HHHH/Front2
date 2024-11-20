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
  http.Response response = await http.post(url, headers: headers, body: body);

  ApiHelper apiHelper = ApiHelper(response.body);
  final return_code = apiHelper.getResultCode();
  if (return_code == 401) {
    print(tokenController.refreshToken.toString());
    final reissueResponse = await http.post(
        Uri.http(SERVER_DOMAIN, "users/reissue"),
        headers: {"refresh": tokenController.refreshToken.toString()});

    final accessToken = reissueResponse.headers["authorization"];
    final refreshToken = reissueResponse.headers["refresh"];

    tokenController.setAccessToken(accessToken.toString());
    tokenController.setRefreshToken(refreshToken.toString());

    if (headers != null && headers.containsKey("Authorization")) {
      headers['Authorization'] = tokenController.accessToken.toString();
    }
    if (headers != null && headers.containsKey("authorization")) {
      headers['authorization'] = tokenController.accessToken.toString();
    }

    // 재요청
    response = await http.post(url, headers: headers, body: body);
  }

  return response;
}

Future<http.Response> ssuDelete(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  final TokenController tokenController = Get.put(TokenController());
  http.Response response = await http.delete(url, headers: headers, body: body);

  ApiHelper apiHelper = ApiHelper(response.body);
  final return_code = apiHelper.getResultCode();
  if (return_code == 401) {
    print(tokenController.refreshToken.toString());
    final reissueResponse = await http.post(
        Uri.http(SERVER_DOMAIN, "users/reissue"),
        headers: {"refresh": tokenController.refreshToken.toString()});

    final accessToken = reissueResponse.headers["authorization"];
    final refreshToken = reissueResponse.headers["refresh"];

    tokenController.setAccessToken(accessToken.toString());
    tokenController.setRefreshToken(refreshToken.toString());

    if (headers != null && headers.containsKey("Authorization")) {
      headers['Authorization'] = tokenController.accessToken.toString();
    }
    if (headers != null && headers.containsKey("authorization")) {
      headers['authorization'] = tokenController.accessToken.toString();
    }

    // 재요청
    response = await http.delete(url, headers: headers, body: body);
  }

  return response;
}

Future<http.Response> ssuGet(Uri url, {Map<String, String>? headers}) async {
  final TokenController tokenController = Get.put(TokenController());
  http.Response response = await http.get(url, headers: headers);

  ApiHelper apiHelper = ApiHelper(response.body);
  final return_code = apiHelper.getResultCode();
  if (return_code == 401) {
    print(tokenController.refreshToken.toString());
    final reissueResponse = await http.post(
        Uri.http(SERVER_DOMAIN, "users/reissue"),
        headers: {"refresh": tokenController.refreshToken.toString()});

    final accessToken = reissueResponse.headers["authorization"];
    final refreshToken = reissueResponse.headers["refresh"];

    tokenController.setAccessToken(accessToken.toString());
    tokenController.setRefreshToken(refreshToken.toString());

    if (headers != null && headers.containsKey("Authorization")) {
      headers['Authorization'] = tokenController.accessToken.toString();
    }
    if (headers != null && headers.containsKey("authorization")) {
      headers['authorization'] = tokenController.accessToken.toString();
    }

    // 재요청
    response = await http.get(url, headers: headers);
  }

  return response;
}

Future<http.StreamedResponse> ssuSend(http.MultipartRequest requests) async {
  //final response = await requests.send();

  final TokenController tokenController = Get.put(TokenController());
  http.StreamedResponse response = await requests.send();
  String responseBody = await response.stream.bytesToString();

  ApiHelper apiHelper = ApiHelper(responseBody);
  final return_code = apiHelper.getResultCode();
  if (return_code == 401) {
    print(tokenController.refreshToken.toString());
    final reissueResponse = await http.post(
        Uri.http(SERVER_DOMAIN, "users/reissue"),
        headers: {"refresh": tokenController.refreshToken.toString()});

    final accessToken = reissueResponse.headers["authorization"];
    final refreshToken = reissueResponse.headers["refresh"];

    tokenController.setAccessToken(accessToken.toString());
    tokenController.setRefreshToken(refreshToken.toString());

    if (requests.headers != null &&
        requests.headers.containsKey("Authorization")) {
      requests.headers['Authorization'] =
          tokenController.accessToken.toString();
    }
    if (requests.headers != null &&
        requests.headers.containsKey("authorization")) {
      requests.headers['authorization'] =
          tokenController.accessToken.toString();
    }

    // 재요청
    response = await requests.send();
  }
  return response;
}
