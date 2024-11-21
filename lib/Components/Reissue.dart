import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:scheduler/Components/ApiHelper.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Controllers/logout_controller.dart';
import 'package:scheduler/Controllers/token_controller.dart';

Future<http.Response> ssuPost(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  final TokenController tokenController = Get.put(TokenController());
  final LogoutController logoutController = Get.put(LogoutController());
  http.Response response = await http.post(url, headers: headers, body: body);

  ApiHelper apiHelper = ApiHelper(response.body);
  final returnCode = apiHelper.getResultCode();
  if (returnCode == 401) {
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
  } else if (returnCode == 403) {
    logoutController.logout();
  }

  return response;
}

Future<http.Response> ssuPatch(Uri url,
    {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
  final TokenController tokenController = Get.put(TokenController());
  final LogoutController logoutController = Get.put(LogoutController());
  http.Response response =
      await http.patch(url, headers: headers, body: body, encoding: encoding);

  ApiHelper apiHelper = ApiHelper(response.body);
  final returnCode = apiHelper.getResultCode();
  if (returnCode == 401) {
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
    response =
        await http.patch(url, headers: headers, body: body, encoding: encoding);
  } else if (returnCode == 403) {
    logoutController.logout();
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
  final LogoutController logoutController = Get.put(LogoutController());
  http.Response response = await http.delete(url, headers: headers, body: body);

  ApiHelper apiHelper = ApiHelper(response.body);
  final returnCode = apiHelper.getResultCode();
  if (returnCode == 401) {
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
  } else if (returnCode == 403) {
    logoutController.logout();
  }

  return response;
}

Future<http.Response> ssuGet(Uri url, {Map<String, String>? headers}) async {
  final TokenController tokenController = Get.put(TokenController());
  final LogoutController logoutController = Get.put(LogoutController());
  http.Response response = await http.get(url, headers: headers);

  ApiHelper apiHelper = ApiHelper(response.body);
  final returnCode = apiHelper.getResultCode();
  if (returnCode == 401) {
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
    } // 재요청
    response = await http.get(url, headers: headers);
  } else if (returnCode == 403) {
    logoutController.logout();
  }

  return response;
}

Future<String> ssuSend(http.MultipartRequest requests) async {
  //final response = await requests.send();
  final TokenController tokenController = Get.put(TokenController());
  final LogoutController logoutController = Get.put(LogoutController());
  http.StreamedResponse response = await requests.send();
  if (response.statusCode != 200) return "";
  String responseBody = await response.stream.bytesToString();

  ApiHelper apiHelper = ApiHelper(responseBody);
  final returnCode = apiHelper.getResultCode();
  if (returnCode == 401) {
    print(tokenController.refreshToken.toString());
    final reissueResponse = await http.post(
        Uri.http(SERVER_DOMAIN, "users/reissue"),
        headers: {"refresh": tokenController.refreshToken.toString()});

    final accessToken = reissueResponse.headers["authorization"];
    final refreshToken = reissueResponse.headers["refresh"];

    tokenController.setAccessToken(accessToken.toString());
    tokenController.setRefreshToken(refreshToken.toString());

    if (requests.headers.containsKey("Authorization")) {
      requests.headers['Authorization'] =
          tokenController.accessToken.toString();
    }
    if (requests.headers.containsKey("authorization")) {
      requests.headers['authorization'] =
          tokenController.accessToken.toString();
    }
    // 재요청
    response = await requests.send();
    if (response.statusCode != 200) return "";
    responseBody = await response.stream.bytesToString();
  } else if (returnCode == 403) {
    logoutController.logout();
  }

  return responseBody;
}
