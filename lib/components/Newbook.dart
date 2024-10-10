import 'package:flutter/material.dart';
import 'package:readers/data/bookdata.dart';

Widget NewBook(Bookdata book) {
  return Container(
    width: double.infinity,
    height: 150.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Book Cover Image
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          height: 128.0,
          width: 83.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  book.bookCover), // Use imageUrl instead of bookCover
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Book Details
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.bookName, // Use title instead of bookName
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                book.author,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.content_copy),
                  Text(book.pageNum.toString()),
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(Icons.star),
                  Text(book.rating.toString()),
                ],
              )
            ],
          ),
        ),
        Icon(Icons.bookmark_border),
      ],
    ),
  );
}
