import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';
import 'package:readers/screen/favotite_screen.dart'; 
import 'package:readers/screen/goal_screen.dart';
import 'package:readers/screen/homgpage_screen.dart';
import 'package:readers/screen/store_screen.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  int _selectedIndex = 2;
  late Future<List<Book>> futureBooks;

  // สร้างรายการเก็บหนังสือที่ถูกบันทึก
  List<Book> savedBooks = [];

  @override
  void initState() {
    super.initState();
    futureBooks =
        fetchBooksFromOpenLibrary('Novel'); // เริ่มต้นค้นหาหนังสือหมวดนิยายทั้งหมด
  }

  Future<List<Book>> fetchBooksFromOpenLibrary(String query) async {
    try {
      final response = await http
          .get(Uri.parse(
              'https://openlibrary.org/search.json?q=$query&limit=10'))
          .timeout(const Duration(seconds: 10)); // กำหนด timeout

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['docs'] != null) {
          final List<dynamic> items = data['docs'];
          return items.map((item) => Book.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load data, status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void searchBooks(String query) {
    setState(() {
      futureBooks = fetchBooksFromOpenLibrary(query);
    });
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GoalsScreen()),
          );
          break;
        case 2: // เปลี่ยนกลับไปยังหน้าหนังสือ
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FavoriteScreen()),
          );
          break;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StoreScreen()),
          );
          break;
      }
    }
  }

  void _toggleBookmark(Book book) {
    setState(() {
      if (savedBooks.contains(book)) {
        savedBooks.remove(book);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${book.title} ถูกลบจาก Bookmark')));
      } else {
        savedBooks.add(book);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${book.title} ถูกบันทึกเป็น Bookmark')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE5E5),
        title: const Text('All Books', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController searchController =
                      TextEditingController();
                  return AlertDialog(
                    title: const Text('ค้นหาหนังสือ'),
                    content: TextField(
                      controller: searchController,
                      decoration:
                          const InputDecoration(hintText: "กรอกคำค้นหา..."),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('ค้นหา'),
                        onPressed: () {
                          searchBooks(searchController.text);
                          Navigator.of(context).pop(); // ปิด dialog
                        },
                      ),
                      TextButton(
                        child: const Text('ยกเลิก'),
                        onPressed: () {
                          Navigator.of(context).pop(); // ปิด dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('ไม่พบหนังสือ.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: 100,
                          height: 150,
                          child: book.coverImage != null
                              ? Image.network(
                                  book.coverImage!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                        child: Icon(Icons.error));
                                  },
                                )
                              : const Center(child: Icon(Icons.book, size: 50)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      book.authors.isNotEmpty
                                          ? book.authors.join(', ')
                                          : 'ไม่มีชื่อผู้เขียน',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.bookmark_border),
                                onPressed: () {
                                  _toggleBookmark(
                                      book); // เรียกใช้งานฟังก์ชัน bookmark
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Goals'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'library'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favortie'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Store'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Book {
  final String title;
  final List<String> authors;
  final String? coverImage;

  Book({required this.title, required this.authors, this.coverImage});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'ไม่มีชื่อหนังสือ',
      authors: List<String>.from(json['author_name'] ?? []),
      coverImage: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg'
          : null,
    );
  }
}
