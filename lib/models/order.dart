import '../interfaces/printable.dart';
import 'book.dart';
import 'user.dart';

class Order implements Printable {
  final String orderId;
  final User user;
  final List<Book> books;
  final double totalPrice;

  Order({
    required this.orderId,
    required this.user,
    required this.books,
    required this.totalPrice,
  });

  @override
  void printDetails() {
    print('=== Order #$orderId ===');
    print('User: ${user.name} (${user.isPremium ? "Premium" : "Regular"})');
    print('Books:');
    for (var book in books) {
      print('- ${book.title}');
    }
    print('Total: \$$totalPrice');
    print('=====================');
  }
}
