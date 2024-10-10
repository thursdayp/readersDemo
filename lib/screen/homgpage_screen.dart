import 'package:flutter/material.dart';
import 'package:readers/Login/login_screen.dart';
import 'package:readers/components/Newbook.dart';
import 'package:readers/components/mybook.dart';
import 'package:readers/data/bookdata.dart';
import 'package:readers/screen/book_screen.dart';
import 'package:readers/screen/favotite_screen.dart';
import 'package:readers/screen/goal_screen.dart';
import 'package:readers/screen/store_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // ฟังก์ชันเมื่อกดที่แต่ละ item ใน BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // กำหนดหน้าต่างๆ เมื่อเลือกแต่ละ tab
    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false,
        ); // ไปยังหน้า Home
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GoalsScreen()),
        ); // ไปยังหน้า Goal
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookScreen()),
        ); // ไปยังหน้า Favorites
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavoriteScreen()),
        ); // ไปยังหน้า Stats
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoreScreen()),
        ); // ไปยังหน้า Settings
        break;
    }
  }

  // Sample list of books
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE5E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE5E5),
        elevation: 0,
        title: const Text(
          'ReadersTrack',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Loginscreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFE6E6E6),
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.all(8.0),
                  hintText: "Search your favorite Book...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "My Books",
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: 280.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length < 4
                      ? books.length
                      : 4, // Display up to 4 books
                  itemBuilder: (context, index) {
                    return myBook(books[index]);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "See Also",
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 12.0),
              Container(
                height: 600.0,
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return NewBook(books[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task),
            label: 'Goal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Store',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
