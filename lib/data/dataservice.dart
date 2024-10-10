// lib/services/data_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:readers/data/b.dart'; // ปรับเส้นทางตามโครงสร้างโปรเจ็คของคุณ

class DataService {
  static const String _bookListKey = 'bookList';
  static const String _totalBooksKey = 'totalBooks';
  static const String _startDateKey = 'startDate';
  static const String _endDateKey = 'endDate';

  Future<void> saveData(List<b> booksRead, int totalBooks, DateTime startDate,
      DateTime endDate) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookListJson = booksRead.map((book) => book.toJson()).toList();
      await prefs.setString(_bookListKey, jsonEncode(bookListJson));
      await prefs.setInt(_totalBooksKey, totalBooks);
      await prefs.setString(_startDateKey, startDate.toIso8601String());
      await prefs.setString(_endDateKey, endDate.toIso8601String());
    } catch (e) {
      print('Error saving data: $e');
      // จัดการข้อผิดพลาด (เช่น แสดงข้อความที่เป็นมิตรกับผู้ใช้)
    }
  }

  Future<Map<String, dynamic>> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookListJson = prefs.getString(_bookListKey);
      final List<b> booksRead = bookListJson != null
          ? (jsonDecode(bookListJson) as List)
              .map((item) => b.fromJson(item))
              .toList()
          : [];
      final int totalBooks = prefs.getInt(_totalBooksKey) ?? 0;
      final startDate = DateTime.parse(
          prefs.getString(_startDateKey) ?? DateTime.now().toIso8601String());
      final endDate = DateTime.parse(prefs.getString(_endDateKey) ??
          DateTime.now().add(Duration(days: 365)).toIso8601String());

      return {
        'booksRead': booksRead,
        'totalBooks': totalBooks,
        'startDate': startDate,
        'endDate': endDate,
      };
    } catch (e) {
      print('Error loading data: $e');
      // จัดการข้อผิดพลาดและส่งคืนค่าเริ่มต้น
      return {
        'booksRead': <b>[],
        'totalBooks': 25,
        'startDate': DateTime.now(),
        'endDate': DateTime.now().add(Duration(days: 365)),
      };
    }
  }
}
