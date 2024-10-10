import 'package:flutter/material.dart';
import 'package:readers/data/bookdata.dart';

Widget myBook(Bookdata book) {
  return Container(
    width: 122.0, // Adjusted width for better spacing
    margin: const EdgeInsets.only(right: 12.0), // Add horizontal spacing
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 121.66,
          height: 180.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(book.bookCover),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 12.0), // Space between image and text
        Text(
          book.bookName,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    ),
  );
}
