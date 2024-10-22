
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'bookinto.dart';

class BookService {
  static const int maxRetries = 3;
  static const int timeoutSeconds = 15;
  
  Future<List<Book>> fetchBooksWithRetry(String query) async {
    int attempts = 0;
    while (attempts < maxRetries) {
      try {
        return await fetchBooksFromOpenLibrary(query);
      } on TimeoutException catch (e) {
        attempts++;
        if (attempts == maxRetries) {
          throw Exception('Failed to load books after $maxRetries attempts: $e');
        }
        // Wait before retrying (exponential backoff)
        await Future.delayed(Duration(seconds: attempts * 2));
      } catch (e) {
        throw Exception('Error fetching books: $e');
      }
    }
    throw Exception('Failed to load books after $maxRetries attempts');
  }

  Future<List<Book>> fetchBooksFromOpenLibrary(String query) async {
    final response = await http
        .get(Uri.parse('https://openlibrary.org/search.json?q=$query&limit=10'))
        .timeout(Duration(seconds: timeoutSeconds));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['docs'] == null) return [];
      
      return List<Book>.from(
        data['docs'].map((item) => Book.fromJson(item))
      ).where((book) => book.isValid()).toList();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}

extension BookValidation on Book {
  bool isValid() {
    return title.isNotEmpty && authors.isNotEmpty && coverImage.isNotEmpty;
  }
}