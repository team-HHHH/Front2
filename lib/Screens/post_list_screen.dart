import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/ConfigJH.dart';
import 'package:scheduler/Models/poster.dart';

class PosterListScreen extends StatefulWidget {
  const PosterListScreen({super.key});

  @override
  State<PosterListScreen> createState() => _PosterListScreenState();
}

class _PosterListScreenState extends State<PosterListScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Poster> _filteredPosters = [];
  final List<Color> _pastelColors = [
    SSU_PASTEL_BLUE,
    SSU_PASTEL_GRAY,
    SSU_PASTEL_GREEN,
    SSU_PASTEL_PURPLE,
    SSU_PASTEL_RED,
    SSU_PASTEL_YELLOW
  ];

  final Offset _dragPosition = const Offset(0, 0);
  final bool _isDragging = false;
  String _selectedDomain = "";

  @override
  void initState() {
    super.initState();
    for (var list in posters.values) {
      _filteredPosters.addAll(list);
    }
  }

  void filterPosters(String domain) {
    int index = int.parse(domain);
    setState(() {
      _filteredPosters = posters[index]!;
      _selectedDomain = domain;
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (_selectedDomain == "") return;
    setState(() {
      int index = int.parse(_selectedDomain);
      _filteredPosters = posters[index]!;
    });
  }

  int makeRandomNumber() {
    final random = Random(); // Random 클래스 생성
    return random.nextInt(24); // 0부터 5까지의 정수 생성
  }

  String calculateDday(String endDate) {
    final DateFormat dateFormat = DateFormat("yyyy.MM.dd");
    DateTime endDateTime = dateFormat.parse(endDate); // endDate를 DateTime으로 변환
    DateTime currentDate = DateTime.now(); // 현재 날짜

    // 남은 일수를 계산
    int difference = endDateTime.difference(currentDate).inDays;
    return difference.toString();
  }

  // void searchPosters(int query){
  //   setState(() {
  //     _filteredPosters = posters.for
  //   });
  // }

  void showAddToCalendarAlert(int index) {
    int domain = int.parse(_selectedDomain);
    final title = _filteredPosters[domain].title;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              color: SSU_BLACK,
              fontSize: 14,
            ),
          ),
          content: const Text("포스터를 캘린더에 넣을까요?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Alert 닫기
              },
              isDefaultAction: true,
              child: const Text(
                "취소",
                style: TextStyle(
                    color: SSU_BLACK,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Alert 닫기
              },
              child: const Text(
                "네",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                    child: CupertinoTextField(
                      placeholder: "공모전 또는 키워드 검색",
                      placeholderStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w100,
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      controller: _searchController,
                      onChanged: (query) {
                        // filterPosters(query);
                      },
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  popUpAnimationStyle: AnimationStyle.noAnimation,
                  elevation: 0.5,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  offset: const Offset(0, 45),
                  icon: const Icon(
                    Icons.menu,
                    size: 16,
                    color: Colors.black,
                  ),
                  onSelected: (selectedValue) {
                    filterPosters(selectedValue);
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<String>(
                        textStyle: TextStyle(
                          color: SSU_BLACK,
                          fontWeight: FontWeight.w100,
                        ),
                        value: '0',
                        height: 36,
                        child: Text('과학/공학'),
                      ),
                      const PopupMenuItem<String>(
                        value: '1',
                        height: 36,
                        textStyle: TextStyle(
                          color: SSU_BLACK,
                          fontWeight: FontWeight.w100,
                        ),
                        child: Text('광고/마케팅'),
                      ),
                      const PopupMenuItem<String>(
                        value: '2',
                        height: 36,
                        textStyle: TextStyle(
                          color: SSU_BLACK,
                          fontWeight: FontWeight.w100,
                        ),
                        child: Text('예술/체육'),
                      ),
                      const PopupMenuItem<String>(
                        value: '3',
                        height: 36,
                        textStyle: TextStyle(
                          color: SSU_BLACK,
                          fontWeight: FontWeight.w100,
                        ),
                        child: Text('디자인/공예'),
                      ),
                      const PopupMenuItem<String>(
                        value: '4',
                        height: 36,
                        textStyle: TextStyle(
                          color: SSU_BLACK,
                          fontWeight: FontWeight.w100,
                        ),
                        child: Text('기획/시나리오'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Uncomment and add ListView here if necessary
            Expanded(
              child: CustomScrollView(
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: _refreshData,
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final poster = _filteredPosters[index];
                        return GestureDetector(
                          onTap: () {
                            showAddToCalendarAlert(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            color: Colors.white,
                            height: 170,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 170,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: _pastelColors[index % 6],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 40,
                                      child: Image.asset(
                                        poster.url, // WebP 이미지 파일
                                        width: 70.0, // 아이콘 크기 설정
                                        height: 100,
                                        fit: BoxFit.contain, // 아이콘 크기 조정
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  poster.title,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.alarm,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      "${calculateDday(poster.endDate)}일 남았습니다.",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.arrow_down_to_line,
                                      size: 12,
                                    ),
                                    Text(
                                      makeRandomNumber().toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 12,
                                    ),
                                    Text(
                                      makeRandomNumber().toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          CupertinoIcons.share,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: _filteredPosters.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 한 줄에 2개의 아이템 배치
                      crossAxisSpacing: 8.0, // 가로 간격
                      mainAxisSpacing: 14.0, // 세로 간격
                      childAspectRatio: 0.8, // 아이템 비율
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const Map<int, List<Poster>> posters = {
  0: [
    Poster(
      url: "assets/images/과학 포스터1.webp",
      title: "원자력 미래기술 아이디어 부트캠프",
      endDate: "2024.12.17",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "assets/images/과학 포스터3.webp",
      title: "서울 크리에이터 유니버스",
      endDate: "2024.11.30",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "assets/images/과학 포스터4.webp",
      title: "스타트업 컨퍼런스",
      endDate: "2024.11.26",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "assets/images/과학 포스터5.webp",
      title: "알서포트 AI 챌린지",
      endDate: "2024.12.17",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "assets/images/과학 포스터6.webp",
      title: "원더차일드 창의발명대회",
      endDate: "2025.01.20",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "assets/images/과학 포스터7.webp",
      title: "이미지 색상화 및 손실 부분 복원 AI 경진대회",
      endDate: "2024.12.09",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "assets/images/과학 포스터8.webp",
      title: "SBA X 슈퍼빌런랩스 게임 콘테스트 공모전",
      endDate: "2024.11.28",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "assets/images/과학 포스터9.webp",
      title: "드론/로봇 배달사진전",
      endDate: "2024.11.29",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "assets/images/과학 포스터10.webp",
      title: "69개의 표지비밀 풀기",
      endDate: "2024.12.31",
      Dday: "5",
      domain: "과학/공학",
    ),
  ],
  1: [
    ///////////////////////
    //////// 광고
    Poster(
      url: "assets/images/광고 포스터1.webp",
      title: "GLOBAL YOUTH IMPACT 해커톤",
      endDate: "2024.12.28",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "assets/images/광고 포스터2.webp",
      title: "숏폼 콘텐츠 공모전",
      endDate: "2025.01.05",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "assets/images/광고 포스터3.webp",
      title: "히든 스팟 추천 공모전",
      endDate: "2024.11.30",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "assets/images/광고 포스터4.webp",
      title: "아시아기계체조선수권대회 상징디자인공모",
      endDate: "2024.11.30",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "assets/images/광고 포스터5.webp",
      title: "봉사사업 아이디어 공모전",
      endDate: "2024.12.10",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "assets/images/광고 포스터6.webp",
      title: "사천시 홍보영상 공모전",
      endDate: "2024.12.05",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "assets/images/광고 포스터7.webp",
      title: "이미지 색상화 및 손실 부분 복원 AI 경진대회",
      endDate: "2024.12.09",
      Dday: "5",
      domain: "광고/마케팅",
    ),
  ],
  2: [
    /////////////////////////////////////////////
    /// 예체능
    ///
    Poster(
      url: "assets/images/예체능 포스터1.webp",
      title: "아티움 음악콩쿠르",
      endDate: "2024.12.17",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "assets/images/예체능 포스터2.webp",
      title: "한국가요작가협회 가요제",
      endDate: "2024.12.10",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "assets/images/예체능 포스터3.webp",
      title: "창작국악동요 작품 공모전",
      endDate: "2025.02.06",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "assets/images/예체능 포스터4.webp",
      title: "생성형 AI 웨딩드레스 화보 공모전",
      endDate: "2024.12.06",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "assets/images/예체능 포스터5.webp",
      title: "BIKAF IN 루브르 미술공모전",
      endDate: "2025.01.09",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "assets/images/예체능 포스터6.webp",
      title: "부천시 관광기념품 공모전",
      endDate: "2025.02.21",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "assets/images/예체능 포스터7.webp",
      title: "ENTERTAINMENT ILMARE 밴드 오디션",
      endDate: "2024.11.29",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "assets/images/예체능 포스터8.webp",
      title: "공부가 즐거워! 송 공모전",
      endDate: "2024.12.20",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "assets/images/예체능 포스터9.webp",
      title: "성수기 일러스트&그래픽 콘테스트",
      endDate: "2024.12.3",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "assets/images/예체능 포스터10.webp",
      title: "STREET ALL-ROUND 춤 배틀",
      endDate: "2025.01.11",
      Dday: "5",
      domain: "예술/체육",
    ),
  ],
  3: [
    ////////////////////////////////////////////////////
    /// 디자인 공예
    Poster(
      url: "assets/images/캐릭터 포스터1.webp",
      title: "청소년 만화 공모전",
      endDate: "2024.12.02",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "assets/images/캐릭터 포스터2.webp",
      title: "계룡시 SNS 콘텐츠 공모전",
      endDate: "2024.12.15",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "assets/images/캐릭터 포스터3.webp",
      title: "JUSTCLICK 캐릭터 공모전",
      endDate: "2025.01.31",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "assets/images/캐릭터 포스터4.webp",
      title: "단편 작가 노블 코믹스 공모전",
      endDate: "2024.11.28",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "assets/images/캐릭터 포스터5.webp",
      title: "태권도 관광/체험형 굿즈 아이디어 공모전",
      endDate: "2024.11.28",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "assets/images/캐릭터 포스터6.webp",
      title: "꿈씨패밀리X대전명소 굿즈 디자인 공모전",
      endDate: "2024.11.29",
      Dday: "5",
      domain: "디자인/공예",
    ),
  ],
  4: [
    ///////////////////////////////////////////
    /// 기획
    Poster(
      url: "assets/images/포스터1.webp",
      title: "2024 시니어 소비자교육 콘텐츠 공모전",
      endDate: "2025.01.20",
      Dday: "5",
      domain: "기획/시나리오",
    ),
    Poster(
      url: "assets/images/포스터2.webp",
      title: "인구구조 변화 대응을 위한 대국민 정책 제안",
      endDate: "2024.12.09",
      Dday: "5",
      domain: "기획/시나리오",
    ),
    Poster(
      url: "assets/images/포스터3.webp",
      title: "팝업스토어 아이디어 공모전",
      endDate: "2024.11.28",
      Dday: "5",
      domain: "기획/시나리오",
    ),
    Poster(
      url: "assets/images/포스터4.webp",
      title: "나의 성장기 수기 공모전",
      endDate: "2024.12.31",
      Dday: "5",
      domain: "기획/시나리오",
    ),
    Poster(
      url: "assets/images/포스터5.webp",
      title: "대학생 학과 소개 공모전",
      endDate: "2024.12.01",
      Dday: "5",
      domain: "기획/시나리오",
    ),
    Poster(
      url: "assets/images/포스터6.webp",
      title: "청년 모바일 사진 & 에세이 공모전",
      endDate: "2024.12.13",
      Dday: "5",
      domain: "기획/시나리오",
    ),
    Poster(
      url: "assets/images/포스터7.webp",
      title: "2025 새해 일출런 공모전",
      endDate: "2025.01.01",
      Dday: "5",
      domain: "기획/시나리오",
    ),
    Poster(
      url: "assets/images/포스터8.webp",
      title: "신년맞이 사행시 아이디어 공모전",
      endDate: "2024.11.29",
      Dday: "5",
      domain: "기획/시나리오",
    ),
    Poster(
      url: "assets/images/포스터9.webp",
      title: "갤러리한옥 불화민화 공모전",
      endDate: "2025.01.15",
      Dday: "5",
      domain: "기획/시나리오",
    ),
    Poster(
      url: "assets/images/포스터10.webp",
      title: "BIKAF IN 루브르 미술 공모전",
      endDate: "2025.01.09",
      Dday: "5",
      domain: "기획/시나리오",
    ),
  ]
};
