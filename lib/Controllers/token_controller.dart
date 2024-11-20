import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scheduler/Components/ApiHelper.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:http/http.dart' as http;

class TokenController extends GetxController {
  final GetStorage _storage = GetStorage(); // GetStorage 인스턴스

  RxString accessToken = ''.obs; // access token을 반응형으로 선언
  RxString refreshToken = ''.obs; // refresh token을 반응형으로 선언

  @override
  void onInit() {
    super.onInit();
    // 컨트롤러 초기화 시 저장된 토큰을 불러오기
    accessToken.value = _storage.read('access_token') ?? '';
    refreshToken.value = _storage.read('refresh_token') ?? '';
  }

  // access token 저장 함수
  void setAccessToken(String token) {
    accessToken.value = token;
    _storage.write('access_token', token); // 로컬에 저장
  }

  // refresh token 저장 함수
  void setRefreshToken(String token) {
    refreshToken.value = token;
    _storage.write('refresh_token', token); // 로컬에 저장
  }

  // 토큰 삭제 함수
  void clearTokens() {
    accessToken.value = '';
    refreshToken.value = '';
    _storage.remove('access_token'); // access token 삭제
    _storage.remove('refresh_token'); // refresh token 삭제
  }

  Future<void> reissue() async {
    final url = Uri.http(SERVER_DOMAIN, "users/reissue");
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken.toString(),
      "Refresh": "Bearer " + refreshToken.toString()
    });

    if (response.statusCode != 200) return;

    final responseData = ApiHelper(response.body);
    final resultCode = responseData.getResultCode();
    final resultMessage = responseData.getResultMessage();
    print(resultMessage);
    if (resultCode != 200) return;

    this.setAccessToken(response.headers["Authorization"].toString());
  }
}
