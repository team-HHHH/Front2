import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Poster {
  final String title;
  final String description;

  Poster({required this.title, required this.description});
}

class PosterListScreen extends StatefulWidget {
  const PosterListScreen({super.key});

  @override
  State<PosterListScreen> createState() => _PosterListScreenState();
}

class _PosterListScreenState extends State<PosterListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Poster> posters = [
    Poster(title: 'Poster 1', description: 'Description for poster 1'),
    Poster(title: 'Poster 2', description: 'Description for poster 2'),
    Poster(title: 'Poster 3', description: 'Description for poster 3'),
  ];
  List<Poster> filteredPosters = [];

  @override
  void initState() {
    super.initState();
    filteredPosters = posters;
  }

  void filterPosters(String query) {
    setState(() {
      filteredPosters = posters
          .where((poster) =>
              poster.title.toLowerCase().contains(query.toLowerCase()) ||
              poster.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
                        filterPosters(query);
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 16,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    final RenderBox button =
                        context.findRenderObject() as RenderBox;
                    final buttonPosition = button.localToGlobal(Offset.zero);
                    final buttonSize = button.size;

                    // 메뉴가 버튼 바로 아래에 뜨도록 위치를 설정
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        buttonPosition.dx,
                        buttonPosition.dy +
                            buttonSize.height, // 버튼 바로 아래에 메뉴가 뜨도록
                        buttonPosition.dx + buttonSize.width,
                        0,
                      ),
                      items: [
                        const PopupMenuItem<String>(
                          value: 'Category 1',
                          child: Text('Category 1'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Category 2',
                          child: Text('Category 2'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Category 3',
                          child: Text('Category 3'),
                        ),
                      ],
                    ).then((selectedValue) {
                      if (selectedValue != null) {
                        print('Selected: $selectedValue');
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: filteredPosters.length,
            //     itemBuilder: (context, index) {
            //       final poster = filteredPosters[index];
            //       return Card(
            //         margin: const EdgeInsets.symmetric(
            //             vertical: 8.0, horizontal: 14),
            //         child: Row(
            //           children: [
            //             Image.asset(
            //               'Assets/images/', // WebP 이미지 파일
            //               width: 30.0, // 아이콘 크기 설정
            //               height: 30.0,
            //               fit: BoxFit.contain, // 아이콘 크기 조정
            //             )
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
