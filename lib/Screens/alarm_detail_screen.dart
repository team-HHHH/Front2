import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scheduler/ConfigJH.dart';

class AlarmDetailScreen extends StatelessWidget {
  const AlarmDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          "공지사항",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: SSU_BLACK,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.arrow_left, size: 20),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "앱 업데이트 소식입니다."
                  "이번 업데이트에서는 포스터 요약 기능이 iOS 17.4 버전으로 업그레이드되었습니다."
                  "이제 iOS 17.4에서 제공하는 새로운 기능과 호환되어 보다 정확하고 빠른 요약 서비스를 제공할 수 있습니다."
                  "이를 통해 사용자들이 포스터 내용을 쉽게 정리하고 필요한 정보를 더 빠르게 확인할 수 있습니다."
                  "앞으로도 더 많은 개선과 기능 추가가 있을 예정이니, 지속적인 관심과 피드백 부탁드립니다.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "2024년 11월 20일",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 0.4,
                  color: SSU_BLACK,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "안녕하세요! 팀 SSU:케쥴러 입니다.\n"
                  "2024년 10월 24일부로 서비스가 시작됨에 따라 사용자 여러분에게 "
                  "더 나은 경험을 제공하고자 다양한 기능을 업데이트했습니다. "
                  "이번 업데이트는 사용성 개선과 함께 앱의 안정성을 강화하는 데 "
                  "중점을 두었으며, 서비스 이용 중 발생할 수 있는 오류를 수정했습니다. "
                  "또한, 향후 업데이트를 통해 더욱 다양한 기능들이 추가될 예정이니 "
                  "많은 기대 부탁드립니다.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "2024년 10월 25일",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 0.4,
                  color: SSU_BLACK,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SSU_GARY {}
