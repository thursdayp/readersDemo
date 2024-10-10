import 'package:flutter/material.dart';
import 'package:readers/data/b.dart';
import 'package:readers/data/bookdata.dart';
import 'package:readers/data/dataservice.dart';
import 'package:readers/screen/book_screen.dart';
import 'package:readers/screen/favotite_screen.dart';
import 'package:readers/screen/homgpage_screen.dart';
import 'package:readers/screen/store_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final DataService _dataService = DataService();
  int _selectedIndex = 1;
  List<b> booksRead = [];
  int totalBooks = 0; // จำนวนหนังสือที่ต้องการอ่านต่อปี
  int additionalBooks = 0; // จำนวนหนังสือเพิ่มเติมที่ต้องการอ่านต่อปี

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 365));

  @override
  void initState() {
    super.initState();
    _loadData();
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
          //Goal page
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BookScreen()),
          );
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

  Future<void> _loadData() async {
    final data = await _dataService.loadData();
    setState(() {
      booksRead = data['booksRead'];
      totalBooks = data['totalBooks'];
      startDate = data['startDate'];
      endDate = data['endDate'];
    });
  }

  Future<void> _saveData() async {
    await _dataService.saveData(booksRead, totalBooks, startDate, endDate);
  }

  String _calculateRemainingDays() {
    final now = DateTime.now();
    final difference = endDate.difference(now).inDays;
    return difference > 0 ? '$difference days remaining' : 'Goal expired';
  }

  void _showEditGoalDialog() {
    DateTime selectedStartDate = startDate;
    int? userDefinedTotalBooks; // ตัวแปรสำหรับเก็บจำนวนหนังสือที่ผู้ใช้กรอก

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Goal Dates'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  hintText:
                      selectedStartDate.toLocal().toString().split(' ')[0],
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedStartDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null &&
                          pickedDate != selectedStartDate) {
                        setState(() {
                          selectedStartDate = pickedDate;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ฟิลด์สำหรับระบุจำนวนหนังสือ
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Books to Read Per Year (min 1)',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  userDefinedTotalBooks = int.tryParse(value);
                },
              ),
              const SizedBox(height: 20),
              // วันสิ้นสุดคำนวณโดยอัตโนมัติ
              Text(
                'End Date: ${selectedStartDate.add(const Duration(days: 365)).toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (userDefinedTotalBooks != null &&
                    userDefinedTotalBooks! >= 1) {
                  setState(() {
                    totalBooks = userDefinedTotalBooks!;
                    startDate = selectedStartDate;
                    endDate = selectedStartDate.add(const Duration(days: 365));
                    _saveData(); // บันทึกข้อมูล
                  });
                  Navigator.of(context).pop();
                } else {
                  // แสดงข้อความเตือนถ้าจำนวนหนังสือน้อยกว่า 1
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter at least 1 book.')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildYearlyGoalCard() {
    int completedBooks = booksRead.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Yearly goal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _showEditGoalDialog, // เรียกใช้ฟังก์ชันแก้ไข
                  child: const Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Started on ${startDate.toLocal().toString().split(' ')[0]}\nEnd on ${endDate.toLocal().toString().split(' ')[0]}',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: completedBooks / (totalBooks + additionalBooks),
                      strokeWidth: 10,
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 255, 187, 255)),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$completedBooks/${totalBooks + additionalBooks}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('Books'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _calculateRemainingDays(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBookDialog() {
    String title = '';
    String author = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Complete Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Author'),
                onChanged: (value) {
                  author = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && author.isNotEmpty) {
                  setState(() {
                    booksRead
                        .add(b(title: title, author: author, imagePath: ''));
                    _saveData(); // บันทึกข้อมูล
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteBook(int index) {
    setState(() {
      booksRead.removeAt(index);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal'),
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
      ),
      body: Column(
        children: [
          _buildYearlyGoalCard(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: booksRead.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(booksRead[index].title),
                  subtitle: Text(booksRead[index].author),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteBook(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookDialog,
        child: const Icon(Icons.add_outlined),
        backgroundColor: const Color.fromARGB(255, 234, 233, 233),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
