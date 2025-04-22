import 'package:flutter/material.dart';
import 'book_detail.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true
      ),
      home: const HomePage(),
      routes: {
        BookDetailPage.routeName: (context) => const BookDetailPage(),
      },
    );
  }
}

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({Key? key}) : super(key: key); // Add constructor for BookDetailPage

  static const String routeName = '/bookDetail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail Page'),
      ),
      body: const Center(
        child: Text('Details about the book go here.'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, BookDetailPage.routeName);
          },
          child: const Text('Go to Book Details'),
        ),
      ),
    );
  }
}