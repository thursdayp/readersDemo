import 'package:flutter/material.dart';
import 'package:readers/screen/book_screen.dart';
import 'package:readers/screen/favotite_screen.dart';
import 'package:readers/screen/homgpage_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowMaterialGrid: false,
        title: 'ReadersTrack Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}
