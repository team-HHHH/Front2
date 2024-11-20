class TagNode {
  final String title;
  final String content;
  final DateTime timeDetail;
  final int tag; //tag number 1:blue, 2:yellow, 3:green, 4:black, 5:red
  final int sid; //scheulder 고유id

  TagNode({
    required this.title,
    required this.content,
    required this.timeDetail,
    required this.tag,
    required this.sid,
  });

  factory TagNode.fromJson(Map<String, dynamic> json) {
    return TagNode(
      title: json['title'],
      content: json['content'],
      timeDetail: DateTime.parse(json['startDay']),
      tag: 0,
      sid: json['calenderId'],
    );
  }
}
