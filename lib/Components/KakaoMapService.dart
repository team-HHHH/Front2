import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KakaoMapPage extends StatefulWidget {
  @override
  _KakaoMapPageState createState() => _KakaoMapPageState();
}

class _KakaoMapPageState extends State<KakaoMapPage> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kakao Map"),
      ),
      body: WebView(
        initialUrl: 'assets/kakao_map.html',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            name: 'MapChannel',
            onMessageReceived: (JavascriptMessage message) {
              // 메시지를 수신하여 위도와 경도를 처리
              final coords = message.message.split(',');
              final latitude = coords[0];
              final longitude = coords[1];
              print(
                  'Clicked Location: Latitude: $latitude, Longitude: $longitude');
            },
          ),
        },
      ),
    );
  }
}
/*

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KakaoMapPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  KakaoMapPage({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    // Kakao 지도 URL
    final String kakaoMapUrl =
        'https://map.kakao.com/link/map/$latitude,$longitude';

    return Scaffold(
      appBar: AppBar(
        title: Text('Kakao Map'),
      ),
      body: WebView(
        initialUrl: kakaoMapUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          // 추가 설정을 여기서 할 수 있습니다.
        },
      ),
    );
  }
}
*/