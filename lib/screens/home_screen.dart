import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<GoogleBooksApi>(context);
    TextEditingController searchController = TextEditingController();