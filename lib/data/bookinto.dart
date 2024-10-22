class Book {
  final String title;
  final List<String> authors; // เปลี่ยนเป็น List<String> เพื่อให้ตรงกับข้อมูล
  final String coverImage;

  Book({
    required this.title,
    required this.authors,
    required this.coverImage,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      authors: List<String>.from(json['author_name'] ?? []), // ตรวจสอบว่าไม่มีค่า null
      coverImage: 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg',
    );
  }
}