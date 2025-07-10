import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../models/book.dart';

class ApiService {
  static Future<List<Book>> fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakerapi.it/api/v1/books?_quantity=10'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final books = data['data'] as List;
        return books
            .map(
              (book) => Book(
                id: book['id'].toString(),
                title: book['title'] ?? 'Unknown Title',
                author: book['author'] ?? 'Unknown Author',
                price: _parsePrice(book),
                description: book['description'] ?? 'No description available',
              ),
            )
            .toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }

  static double _parsePrice(Map<String, dynamic> book) {
    final random = Random();
    final price = 10.0 + (random.nextDouble() * 40.0);
    return double.parse(price.toStringAsFixed(2)); 
  }
}
