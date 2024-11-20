import 'dart:convert';

class ApiHelper {
  var responseData;

  // ApiHelper(response.body) 생성자
  ApiHelper(String response) {
    responseData = jsonDecode(response);
  }

  Map<String, dynamic> _getResult() {
    final Map<String, dynamic> result = responseData['result'];
    return result;
  }

  Map<String, dynamic> _getBody() {
    final Map<String, dynamic> body = responseData['body'];
    return body;
  }

  String getResultMessage() {
    final String resultMessage = _getResult()["resultMessage"];
    return resultMessage;
  }

  int getResultCode() {
    final resultCode = _getResult()["resultCode"];
    return resultCode;
  }

  dynamic getBodyValue(String key) {
    final Map<String, dynamic> body = _getBody()[key];
    return body;
  }

  dynamic getBodyValueOne(String key) {
    return _getBody()[key];
  }

  dynamic getBody() {
    return responseData['body'];
  }
}
