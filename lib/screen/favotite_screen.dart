import 'package:flutter/material.dart';
import 'package:readers/screen/book_screen.dart';
import 'package:readers/screen/goal_screen.dart';
import 'package:readers/screen/homgpage_screen.dart';
import 'package:readers/screen/store_screen.dart';
import 'package:readers/data/bookdata.dart';
import 'package:readers/components/mybook.dart';

class Playlist {
  String name;
  List<Book> books;

  Playlist({required this.name, required this.books});
}

class Book {
  String title;

  Book({required this.title});
}

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 3; // Default to Favorites screen
  final ScrollController _scrollController =
      ScrollController(); // Scroll controller
  List<Playlist> playlists = []; // รายการ Playlist

  void _addPlaylist() {
    TextEditingController playlistController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('สร้าง Playlist ใหม่'),
          content: TextField(
            controller: playlistController,
            decoration: const InputDecoration(hintText: "กรอกชื่อ Playlist"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('สร้าง'),
              onPressed: () {
                if (playlistController.text.isNotEmpty) {
                  setState(() {
                    playlists.add(
                        Playlist(name: playlistController.text, books: []));
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deletePlaylist(Playlist playlist) {
    setState(() {
      playlists.remove(playlist);
    });
  }

  void _showPlaylistDetail(Playlist playlist) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(playlist.name),
          content: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: playlist.books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(playlist.books[index].title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        playlist.books.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ลบ Playlist'),
              onPressed: () {
                _deletePlaylist(playlist);
                Navigator.of(context).pop(); // Close dialog after deletion
              },
            ),
            TextButton(
              child: const Text('ปิด'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final List<Bookdata> books = [
    new Bookdata(
        'https://storage.naiin.com/system/application/bookstore/resource/product/202304/577274/1000260516_front_XXL.jpg?imgname=%E0%B8%88%E0%B8%B4%E0%B8%95%E0%B8%A7%E0%B8%B4%E0%B8%97%E0%B8%A2%E0%B8%B2%E0%B8%AA%E0%B8%B2%E0%B8%A2%E0%B8%94%E0%B8%B2%E0%B8%A3%E0%B9%8C%E0%B8%81', // Replace with actual book cover URLs
        'จิตวิทยาสายดาร์ก',
        'Dr.Hiro',
        250,
        4.5),
    new Bookdata(
        'https://storage.naiin.com/system/application/bookstore/resource/product/202409/624110/1000275712_front_XXL.jpg?imgname=%E0%B9%80%E0%B8%A3%E0%B8%B2%E0%B8%AD%E0%B8%B2%E0%B8%88%E0%B9%81%E0%B8%84%E0%B9%88%E0%B8%95%E0%B9%89%E0%B8%AD%E0%B8%87%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%82%E0%B8%AD%E0%B8%81%E0%B8%B2%E0%B8%AA%E0%B8%AA%E0%B8%B1%E0%B8%81%E0%B8%84%E0%B8%A3%E0%B8%B1%E0%B9%89%E0%B8%87%E0%B8%88%E0%B8%B2%E0%B8%81%E0%B8%95%E0%B8%B1%E0%B8%A7%E0%B9%80%E0%B8%AD%E0%B8%87',
        'เราอาจแค่ต้องการโอกาสสักครั้งจากตัวเอง',
        'คุณ (ONCE)',
        280,
        5.0),
    new Bookdata(
        'https://storage.naiin.com/system/application/bookstore/resource/product/202410/624908/1000275995_front_XXL.jpg?imgname=%E0%B8%AB%E0%B8%B2%E0%B8%81%E0%B8%96%E0%B8%B2%E0%B8%A1%E0%B8%A7%E0%B9%88%E0%B8%B2%E0%B8%8A%E0%B8%B5%E0%B8%A7%E0%B8%B4%E0%B8%95%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%9C%E0%B9%88%E0%B8%B2%E0%B8%99%E0%B8%A1%E0%B8%B2%E0%B8%89%E0%B8%B1%E0%B8%99%E0%B9%80%E0%B8%84%E0%B8%A2%E0%B9%80%E0%B8%AA%E0%B8%B5%E0%B8%A2%E0%B9%83%E0%B8%88%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B9%84%E0%B8%AB%E0%B8%99%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%AA%E0%B8%B8', // Replace with actual book cover URLs
        'หากถามว่าชีวิตที่ผ่านมาฉันเคยเสียใจเรื่องไหนที่สุด',
        'KnowT',
        230,
        4.5),
    new Bookdata(
        'https://storage.naiin.com/system/application/bookstore/resource/product/202109/533411/1000243428_front_XXL.jpg?imgname=%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%84%E0%B8%A5%E0%B8%B7%E0%B9%88%E0%B8%99%E0%B8%9E%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B8%9A%E0%B8%A7%E0%B8%81%E0%B8%94%E0%B8%B6%E0%B8%87%E0%B8%94%E0%B8%B9%E0%B8%94%E0%B8%9E%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B8%AA%E0%B8%B8%E0%B8%82',
        'ใช้คลื่นพลังบวกดึงดูดพลังสุข',
        'Vex King (เว็กซ์ คิงส์)',
        350,
        4.9),
    new Bookdata(
        'https://storage.naiin.com/system/application/bookstore/resource/product/202410/624867/1000275891_front_XXL.jpg?imgname=95-%E0%B8%A7%E0%B8%B4%E0%B8%8A%E0%B8%B2%E0%B8%8A%E0%B8%B5%E0%B8%A7%E0%B8%B4%E0%B8%95-%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%97%E0%B8%B3%E0%B9%83%E0%B8%AB%E0%B9%89%E0%B9%80%E0%B8%A3%E0%B8%B2%E0%B8%9E%E0%B8%81%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%E0%B8%AA%E0%B8%B8%E0%B8%82%E0%B9%84%E0%B8%9B%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%97%E0%B8%B5%E0%B9%88-',
        '95 วิชาชีวิต ที่ทำให้เราพกความสุขไปทุกที่',
        'เสือ เสือพลี (กวีอินดี้)',
        240,
        4.6),
    new Bookdata(
        'https://storage.naiin.com/system/application/bookstore/resource/product/202409/624516/1000275885_front_XXL.jpg?imgname=%E0%B8%AA%E0%B8%B8%E0%B8%82%E0%B8%8A%E0%B8%99%E0%B8%9A%E0%B8%97-(%E0%B8%89%E0%B8%9A%E0%B8%B1%E0%B8%9A%E0%B8%9B%E0%B8%A3%E0%B8%B1%E0%B8%9A%E0%B8%9B%E0%B8%A3%E0%B8%B8%E0%B8%87)',
        'สุขชนบท (ฉบับปรับปรุง)',
        'คิ้วตํ่า',
        250,
        4.5),
    // Add more books as needed
  ];

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
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BookScreen()),
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

  void _scrollTo(double offset) {
    _scrollController.animateTo(
      _scrollController.position.pixels + offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        backgroundColor: const Color(0xFFFFE5E5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addPlaylist, // เปิดฟังก์ชันเพิ่ม Playlist
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const Text(
              "My Books",
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 280.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return myBook(books[index]); // Create book card
                    },
                  ),
                  Positioned(
                    left: 16.0,
                    top: 100.0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        _scrollTo(-100); // Scroll left
                      },
                    ),
                  ),
                  Positioned(
                    right: 16.0,
                    top: 100.0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        _scrollTo(100); // Scroll right
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Goals'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
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
