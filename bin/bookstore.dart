import 'dart:io';

import 'package:bookstore/interfaces/discountable.dart';
import 'package:bookstore/models/book.dart';
import 'package:bookstore/models/order.dart';
import 'package:bookstore/models/user.dart';
import 'package:bookstore/services/api_service.dart';
import 'package:bookstore/utils/input_helper.dart';

class BookstoreApp {
  List<Book> books = [];
  User? currentUser;
  List<Order> orders = [];
  int orderCounter = 1;

  Future<void> run() async {
    print('Welcome to Dart Bookstore\n');

    while (true) {
      printMainMenu();
      final choice = InputHelper.getChoice('Enter your choice (1-6): ', [
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
      ]);

      switch (choice) {
        case '1':
          await viewAvailableBooks();
          break;
        case '2':
          await searchBooks();
          break;
        case '3':
          registerUser();
          break;
        case '4':
          purchaseBooks();
          break;
        case '5':
          viewOrderHistory();
          break;
        case '6':
          print('\nThank you for using Dart Bookstore. Goodbye!');
          exit(0);
        default:
          print('\nInvalid choice. Please try again.\n');
      }
    }
  }

  void printMainMenu() {
    print('Please choose an option:');
    print('1. View available books');
    print('2. Search books by keyword');
    print('3. Register a user');
    print('4. Purchase books');
    print('5. View order history');
    print('6. Exit');
  }

  Future<void> viewAvailableBooks() async {
    if (books.isEmpty) {
      print('\nFetching books...');
      books = await ApiService.fetchBooks();
      if (books.isEmpty) {
        print('No books available at the moment.\n');
        return;
      }
    }

    print('\nAvailable Books:');
    for (var book in books) {
      book.printDetails();
    }
  }

  Future<void> searchBooks() async {
    if (books.isEmpty) {
      print('\nFetching books...');
      books = await ApiService.fetchBooks();
      if (books.isEmpty) {
        print('No books available to search.\n');
        return;
      }
    }

    final keyword = InputHelper.getUserInput(
      '\nEnter keyword to search (title, author, or description): ',
    ).toLowerCase();

    if (keyword.trim().isEmpty) {
      print('\nPlease enter a valid keyword.\n');
      return;
    }

    final matchingBooks = books.where((book) {
      return book.title.toLowerCase().contains(keyword) ||
          book.author.toLowerCase().contains(keyword) ||
          book.description.toLowerCase().contains(keyword);
    }).toList();

    if (matchingBooks.isEmpty) {
      print('\nNo books found matching "$keyword".\n');
    } else {
      print('\nFound ${matchingBooks.length} book(s) matching "$keyword":');
      for (var book in matchingBooks) {
        book.printDetails();
      }
    }
  }

  void registerUser() {
    print('\nRegister a new user:');
    final name = InputHelper.getValidName('Enter your name: ');
    final email = InputHelper.getValidEmail('Enter your email: ');
    final isPremium = InputHelper.getConfirmation('Are you a premium user?');

    if (isPremium) {
      currentUser = PremiumUser(name: name, email: email);
    } else {
      currentUser = User(name: name, email: email);
    }

    print('\nUser registered successfully!\n');
    currentUser!.printDetails();
    print('');
  }

  void purchaseBooks() {
    if (currentUser == null) {
      print('\nPlease register a user first.\n');
      return;
    }

    if (books.isEmpty) {
      print('\nNo books available to purchase. Please fetch books first.\n');
      return;
    }

    print('\nAvailable Books:');
    for (var book in books) {
      print('[${book.id}] ${book.title} - \$${book.price.toStringAsFixed(2)}');
    }

    final bookIds = InputHelper.getCommaSeparatedIds(
      '\nEnter book IDs to purchase (comma separated): ',
    );

    final selectedBooks = <Book>[];
    double totalPrice = 0;

    for (var id in bookIds) {
      final book = books.firstWhere(
        (book) => book.id == id,
        orElse: () =>
            Book(id: '', title: '', author: '', price: 0, description: ''),
      );
      if (book.id.isNotEmpty) {
        selectedBooks.add(book);
        totalPrice += book.price;
      }
    }

    if (selectedBooks.isEmpty) {
      print('\nNo valid books selected.\n');
      return;
    }

    double finalPrice = totalPrice;
    if (currentUser is Discountable) {
      final discountableUser = currentUser as Discountable;
      finalPrice = discountableUser.applyDiscount(totalPrice);
      print('\nOriginal price: \$${totalPrice.toStringAsFixed(2)}');
      print('Premium discount applied: 10%');
    }

    print('Final price: \$${finalPrice.toStringAsFixed(2)}');

    final confirm = InputHelper.getConfirmation('Confirm purchase?');
    if (confirm) {
      final orderId = 'ORD${orderCounter.toString().padLeft(3, '0')}';
      orderCounter++;

      final order = Order(
        orderId: orderId,
        user: currentUser!,
        books: selectedBooks,
        totalPrice: finalPrice,
      );
      orders.add(order);
      currentUser!.purchasedBooks.addAll(selectedBooks);

      print('\nOrder placed successfully! Order ID: $orderId\n');
    } else {
      print('\nPurchase cancelled.\n');
    }
  }

  void viewOrderHistory() {
    if (orders.isEmpty) {
      print('\nNo orders found.\n');
      return;
    }

    print('\nOrder History:');
    for (var order in orders) {
      order.printDetails();
    }
  }
}

void main() async {
  final app = BookstoreApp();
  await app.run();
}
