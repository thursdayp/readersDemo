class b {
  final String title;
  final String author;
  final String imagePath; // เพิ่มตัวแปรนี้

  b(
      {required this.title,
      required this.author,
      required this.imagePath}); // แก้ไขคอนสตรัคเตอร์

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
        'imagePath': imagePath, // เพิ่มตัวแปรนี้ใน toJson
      };

  factory b.fromJson(Map<String, dynamic> json) => b(
        title: json['title'],
        author: json['author'],
        imagePath: json['imagePath'], // เพิ่มตัวแปรนี้ใน fromJson
      );
}
