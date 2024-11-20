import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void showAddressSearchDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('주소 검색'),
        content: Container(
          width: double.maxFinite,
          height: 400, // 원하는 높이
          child: WebView(
            initialUrl: 'https://map.kakao.com/', // 카카오 지도 주소
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('닫기'),
          ),
        ],
      );
    },
  );
}
