import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleBooksApi extends ChangeNotifier {
  // Use a more descriptive name like _bookItems to indicate a list of Book objects
  List<dynamic> _bookItems = [];

  // Use a more specific name like _isLoadingData to describe the loading state
  bool _isLoadingData = false;

  // Encapsulate the API key as it's a sensitive piece of information, Consider using environment variables
  static const String _apiKey = 'AIzaSyBAMzraxid-z31u9SgZxmCDB80QIlggLfY';

  // Using a more descriptive constant name for better readability
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  // Add a getter to access the list of book items safely
  List<dynamic> get bookItems => _bookItems;

  // Add a getter to check the loading state
  bool get isLoadingData => _isLoadingData;

  // Function to search books based on user query, use a more specific name like searchBooks
  Future<void> searchBooks(String query) async {
    // Construct the URL using Uri.https for better security
    final uri = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': query,
      'key': _apiKey,
    });

    // Use a more descriptive variable name like previousLoadingState
    final bool previousLoadingState = _isLoadingData;

    // Set loading state to true (start fetching) only if not already loading, notify listeners
    if (!previousLoadingState) {
      _isLoadingData = true;
      notifyListeners();
    }

    try {
      // Make HTTP GET request to Google Books API
      final response = await http.get(uri);

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);
        _bookItems = data['items'] ?? [];
      } else {
        // Throw an error to be caught outside if needed
        throw Exception(
            'Failed to load books: Status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle the error, log it, or display a message to the user
      print('Error fetching books: $error');
      // Use clear method to avoid any confusion
      _bookItems.clear();
    } finally {
      // Set loading state to false (done fetching), notify listeners
      // Set loading state to false only if it was true before the request
      if (previousLoadingState) {
        _isLoadingData = false;
        notifyListeners();
      }
    }
  }
}