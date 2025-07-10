import '../interfaces/printable.dart';

class Book implements Printable {
  final String id;
  final String title;
  final String author;
  final double price;
  final String description;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.description,
  });

  @override
  void printDetails() {
    print('[ID: $id]');
    print('Title: $title');
    print('Author: $author');
    print('Price: \$$price');
    print('Description: $description');
    print('---------------------');
  }
}
