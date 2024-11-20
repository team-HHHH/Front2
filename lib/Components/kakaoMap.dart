import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scheduler/Components/KakaoMapService.dart';
import 'dart:convert';

Future<Map<String, double>?> getCoordinatesFromAddress(String address) async {
  final String apiKey = '9670bb1770652a98ad47a42b359ceb2c';
  final String url =
      'https://dapi.kakao.com/v2/local/search/address.json?query=$address';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'KakaoAK $apiKey', // API 키를 헤더에 추가
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // 위도와 경도 추출
      var latitude = data['documents'][0]['y'];
      var longitude = data['documents'][0]['x'];
      print('Latitude: $latitude, Longitude: $longitude');
      return {
        'latitude': double.parse(latitude),
        'longitude': double.parse(longitude)
      };
    } else {
      print('Failed to load coordinates: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
