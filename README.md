# Dart Bookstore 📚

A comprehensive command-line bookstore application built with Dart that allows users to browse, search, and purchase books with premium user features.

## Features ✨

- **📖 Book Management**: Browse and search books fetched from external API
- **🔍 Advanced Search**: Search books by title, author, or description
- **👤 User System**: Register as regular or premium user
- **🛒 Shopping Cart**: Purchase multiple books with order tracking
- **💳 Premium Discounts**: 10% discount for premium users
- **📋 Order History**: View complete purchase history
- **✅ Input Validation**: Robust input handling and validation

## Project Structure 📁

```
bookstore/
├── bin/
│   └── bookstore.dart          # Main application entry point
├── lib/
│   ├── bookstore.dart          # Library exports
│   ├── interfaces/
│   │   ├── discountable.dart   # Discount interface for premium users
│   │   └── printable.dart      # Print interface for displaying details
│   ├── models/
│   │   ├── book.dart           # Book data model
│   │   ├── order.dart          # Order data model
│   │   └── user.dart           # User models (User, PremiumUser)
│   ├── services/
│   │   └── api_service.dart    # External API integration
│   └── utils/
│       └── input_helper.dart   # Input validation utilities
├── test/
│   └── bookstore_test.dart     # Unit tests
├── pubspec.yaml                # Dependencies and metadata
└── README.md                   # This documentation
```

## Installation & Setup 🚀

### Prerequisites

- Dart SDK 3.8.1 or higher
- Internet connection (for fetching books from API)

### Installation Steps

1. **Clone or download the project**

   ```bash
   git clone <repository-url>
   cd bookstore
   ```

2. **Install dependencies**

   ```bash
   dart pub get
   ```

3. **Run the application**
   ```bash
   dart run bin/bookstore.dart
   ```

## Usage Guide 📖

### Main Menu Options

When you start the application, you'll see the main menu:

```
Please choose an option:
1. View available books
2. Search books by keyword
3. Register a user
4. Purchase books
5. View order history
6. Exit
```

### 1. View Available Books

- Displays all available books with details
- Books are fetched automatically from external API
- Shows book ID, title, author, price, and description

### 2. Search Books by Keyword

- Search through book titles, authors, and descriptions
- Case-insensitive search
- Returns all matching results with full details

### 3. Register a User

- **Name**: Letters and spaces only
- **Email**: Valid email format required
- **User Type**: Choose between Regular or Premium user
- Premium users get 10% discount on all purchases

### 4. Purchase Books

- **Prerequisites**: Must register a user first
- View available books with IDs and prices
- Enter comma-separated book IDs to purchase
- Automatic price calculation with premium discounts
- Order confirmation and unique order ID generation

### 5. View Order History

- Displays all completed orders
- Shows order details, books purchased, and total amounts

## User Types 👥

### Regular User

- Basic functionality
- Full price for all purchases
- Complete order tracking

### Premium User

- All regular user features
- **10% discount** on all purchases
- Implements `Discountable` interface

## API Integration 🌐

The application fetches book data from:

- **API**: `https://fakerapi.it/api/v1/books`
- **Features**: Automatic price generation (randomized between $10-$50)
- **Error Handling**: Graceful fallback with user-friendly messages

## Input Validation 🔒

### Robust Input Handling

- **Email Validation**: Regex-based email format checking
- **Name Validation**: Letters and spaces only
- **Choice Validation**: Menu options with retry on invalid input
- **Confirmation Prompts**: Flexible yes/no responses
- **ID Validation**: Comma-separated book ID parsing

### Error Prevention

- Empty input protection
- Invalid choice handling
- Graceful error recovery
- Clear user feedback

## Code Architecture 🏗️

### Design Patterns

- **Interface-based Design**: `Printable` and `Discountable` interfaces
- **Service Layer**: Separated API logic in `ApiService`
- **Model-View Separation**: Clear data models and presentation logic
- **Utility Classes**: Reusable input validation helpers

### Key Classes

#### Models

- `Book`: Represents book data with print capabilities
- `User`: Base user class with purchase tracking
- `PremiumUser`: Extended user with discount functionality
- `Order`: Order data with complete purchase details

#### Services

- `ApiService`: Handles external API communication
- `InputHelper`: Comprehensive input validation utilities

#### Interfaces

- `Printable`: Standardized detail printing
- `Discountable`: Discount calculation contract

## Testing 🧪

Run the test suite:

```bash
dart test
```

Tests cover:

- Model functionality
- Input validation
- Business logic
- Error handling

## Development 💻

### Adding New Features

1. Create appropriate models in `lib/models/`
2. Add service logic in `lib/services/`
3. Update main application in `bin/bookstore.dart`
4. Add tests in `test/`

### Code Style

- Follow Dart conventions
- Use meaningful variable names
- Implement interfaces where appropriate
- Add comprehensive error handling

## Dependencies 📦

```yaml
dependencies:
  http: ^1.1.0 # For API requests

dev_dependencies:
  lints: ^5.0.0 # Code analysis
  test: ^1.24.0 # Testing framework
```

## Troubleshooting 🔧

### Common Issues

**"Error fetching books"**

- Check internet connection
- API might be temporarily unavailable
- Application continues with cached books if available

**"Cannot add to an unmodifiable list"**

- This has been fixed in the current version
- User purchase history is now properly mutable

**Input validation errors**

- Follow the prompted format exactly
- Email must include @ and domain
- Names should only contain letters and spaces

## Contributing 🤝

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## License 📄

This project is available under the MIT License.

## Future Enhancements 🚧

- [ ] Book categories and filtering
- [ ] User authentication with passwords
- [ ] Wishlist functionality
- [ ] Book reviews and ratings
- [ ] Inventory management
- [ ] Multiple payment methods
- [ ] Order status tracking
- [ ] Export order history

---

**Built with ❤️ using Dart**
