import 'package:flutter/material.dart';
import 'package:readers/screen/book_screen.dart';
import 'package:readers/screen/favotite_screen.dart';
import 'package:readers/screen/goal_screen.dart';
import 'package:readers/screen/homgpage_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int _selectedIndex = 4;

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
          (Route<dynamic> route) => false, // Remove all previous routes
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
        // Already on Store, no need to navigate // ไปยังหน้า Stats // ไปยังหน้า Settings
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
         backgroundColor: const Color(0xFFFFE5E5),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Readers Track Store',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Store content, e.g. upgrade options, featured books, etc.
            ElevatedButton(
              onPressed: () {
                // TODO: Implement upgrade functionality
              },
              child: const Text('Upgrade to Pro'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            const SizedBox(height: 20),
            // Example content: List of products or features
            const Text('Pro Features:'),
            const ListTile(
              leading: Icon(Icons.check),
              title: Text('Unlimited book tracking'),
            ),
            const ListTile(
              leading: Icon(Icons.check),
              title: Text('Ad-free experience'),
            ),
            const ListTile(
              leading: Icon(Icons.check),
              title: Text('Access to exclusive content'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Goals'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'library'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favortie'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Store'),
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
