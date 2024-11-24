import 'dart:core';

class Poster {
  final String title;
  final String endDate;
  final String Dday;
  final String domain;
  final String url;

  const Poster({
    required this.url,
    required this.title,
    required this.endDate,
    required this.Dday,
    required this.domain,
  });
}

const Map<int, List<Poster>> posters = {
  0: [
    Poster(
      url: "Assets/과학 포스터1.webpg",
      title: "원자력 미래기술 아이디어 부트캠프",
      endDate: "2024.12.17",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "Assets/과학 포스터3.webpg",
      title: "서울 크리에이터 유니버스",
      endDate: "2024.11.30",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "Assets/과학 포스터4.webpg",
      title: "스타트업 컨퍼런스",
      endDate: "2024.11.26",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "Assets/과학 포스터5.webpg",
      title: "알서포트 AI 챌린지",
      endDate: "2024.12.17",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "Assets/과학 포스터6.webpg",
      title: "원더차일드 창의발명대회",
      endDate: "2024.01.20",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "Assets/과학 포스터7.webpg",
      title: "이미지 색상화 및 손실 부분 복원 AI 경진대회",
      endDate: "2024.12.09",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "Assets/과학 포스터8.webpg",
      title: "SBA X 슈퍼빌런랩스 게임 콘테스트 공모전",
      endDate: "2024.11.28",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "Assets/과학 포스터9.webpg",
      title: "드론/로봇 배달사진전",
      endDate: "2024.11.29",
      Dday: "5",
      domain: "과학/공학",
    ),
    Poster(
      url: "Assets/과학 포스터10.webpg",
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
      url: "Assets/광고 포스터1.webpg",
      title: "GLOBAL YOUTH IMPACT 해커톤",
      endDate: "2024.12.28",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "Assets/광고 포스터2.webpg",
      title: "숏폼 콘텐츠 공모전",
      endDate: "2024.01.05",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "Assets/광고 포스터3.webpg",
      title: "히든 스팟 추천 공모전",
      endDate: "2024.11.30",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "Assets/광고 포스터4.webpg",
      title: "아시아기계체조선수권대회 상징디자인공모",
      endDate: "2024.11.30",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "Assets/광고 포스터5.webpg",
      title: "봉사사업 아이디어 공모전",
      endDate: "2024.12.10",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "Assets/광고 포스터6.webpg",
      title: "사천시 홍보영상 공모전",
      endDate: "2024.12.05",
      Dday: "5",
      domain: "광고/마케팅",
    ),
    Poster(
      url: "Assets/광고 포스터7.webpg",
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
      url: "Assets/예체능 포스터1.webpg",
      title: "아티움 음악콩쿠르",
      endDate: "2024.12.17",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "Assets/예체능 포스터2.webpg",
      title: "한국가요작가협회 가요제",
      endDate: "2024.12.10",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "Assets/예체능 포스터3.webpg",
      title: "창작국악동요 작품 공모전",
      endDate: "2024.02.06",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "Assets/예체능 포스터4.webpg",
      title: "생성형 AI 웨딩드레스 화보 공모전",
      endDate: "2024.12.06",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "Assets/예체능 포스터5.webpg",
      title: "BIKAF IN 루브르 미술공모전",
      endDate: "2024.01.09",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "Assets/예체능 포스터6.webpg",
      title: "부천시 관광기념품 공모전",
      endDate: "2024.02.021",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "Assets/예체능 포스터7.webpg",
      title: "ENTERTAINMENT ILMARE 밴드 오디션",
      endDate: "2024.11.29",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "Assets/예체능 포스터8.webpg",
      title: "공부가 즐거워! 송 공모전",
      endDate: "2024.12.20",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "Assets/예체능 포스터9.webpg",
      title: "성수기 일러스트&그래픽 콘테스트",
      endDate: "2024.12.3",
      Dday: "5",
      domain: "예술/체육",
    ),
    Poster(
      url: "Assets/예체능 포스터10.webpg",
      title: "STREET ALL-ROUND 춤 배틀",
      endDate: "2024.01.11",
      Dday: "5",
      domain: "예술/체육",
    ),
  ],
  3: [
    ////////////////////////////////////////////////////
    /// 디자인 공예
    Poster(
      url: "Assets/캐릭터 포스터1.webpg",
      title: "청소년 만화 공모전",
      endDate: "2024.12.02",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/캐릭터 포스터2.webpg",
      title: "계룡시 SNS 콘텐츠 공모전",
      endDate: "2024.12.15",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/캐릭터 포스터3.webpg",
      title: "JUSTCLICK 캐릭터 공모전",
      endDate: "2024.01.31",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/캐릭터 포스터4.webpg",
      title: "단편 작가 노블 코믹스 공모전",
      endDate: "2024.11.28",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/캐릭터 포스터5.webpg",
      title: "태권도 관광/체험형 굿즈 아이디어 공모전",
      endDate: "2024.11.28",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/캐릭터 포스터6.webpg",
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
      url: "Assets/포스터1.webpg",
      title: "2024 시니어 소비자교육 콘텐츠 공모전",
      endDate: "2024.01.20",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/포스터2.webpg",
      title: "인구구조 변화 대응을 위한 대국민 정책 제안",
      endDate: "2024.12.09",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/포스터3.webpg",
      title: "팝업스토어 아이디어 공모전",
      endDate: "2024.11.28",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/포스터4.webpg",
      title: "나의 성장기 수기 공모전",
      endDate: "2024.12.31",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/포스터5.webpg",
      title: "대학생 학과 소개 공모전",
      endDate: "2024.12.01",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/포스터6.webpg",
      title: "청년 모바일 사진 & 에세이 공모전",
      endDate: "2024.12.13",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/포스터7.webpg",
      title: "2025 새해 일출런 공모전",
      endDate: "2024.01.01",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/포스터8.webpg",
      title: "신년맞이 사행시 아이디어 공모전",
      endDate: "2024.11.29",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/포스터9.webpg",
      title: "갤러리한옥 불화민화 공모전",
      endDate: "2024.01.15",
      Dday: "5",
      domain: "디자인/공예",
    ),
    Poster(
      url: "Assets/포스터10.webpg",
      title: "BIKAF IN 루브르 미술 공모전",
      endDate: "2024.01.09",
      Dday: "5",
      domain: "디자인/공예",
    ),
  ]
};
