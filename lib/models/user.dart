import '../interfaces/discountable.dart';
import '../interfaces/printable.dart';
import 'book.dart';

class User implements Printable {
  final String name;
  final String email;
  final List<Book> purchasedBooks;
  bool isPremium;

  User({
    required this.name,
    required this.email,
    List<Book>? purchasedBooks,
    this.isPremium = false,
  }) : purchasedBooks = purchasedBooks ?? <Book>[];

  @override
  void printDetails() {
    print('Name: $name');
    print('Email: $email');
    print('Type: ${isPremium ? "Premium" : "Regular"}');
  }
}

class PremiumUser extends User implements Discountable {
  PremiumUser({required super.name, required super.email, super.purchasedBooks})
    : super(isPremium: true);

  @override
  double applyDiscount(double price) {
    return price * 0.9;
  }
}
