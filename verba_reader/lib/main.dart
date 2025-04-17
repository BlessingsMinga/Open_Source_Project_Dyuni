import 'package:flutter/material.dart';
import 'book_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {,
      },
    );
  }
}

BookDetailPage() {}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Book Details'),
          onPressed: () {
            Navigator.pushNamed(context, '/bookDetail');
          },
        ),
      ),
    );
  }
}
