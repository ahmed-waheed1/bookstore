import 'dart:io';

class InputHelper {
  static String getUserInput(String prompt, {bool allowEmpty = false}) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync()?.trim() ?? '';

      if (input.isNotEmpty || allowEmpty) {
        return input;
      }

      print('Input cannot be empty. Please try again.');
    }
  }

  static String getValidEmail(String prompt) {
    while (true) {
      final email = getUserInput(prompt);

      if (isValidEmail(email)) {
        return email;
      }

      print('Please enter a valid email address (e.g., user@example.com).');
    }
  }

  static bool getConfirmation(String prompt) {
    while (true) {
      final input = getUserInput('$prompt (yes/no): ').toLowerCase();

      if (input == 'yes' || input == 'y') {
        return true;
      } else if (input == 'no' || input == 'n') {
        return false;
      }

      print('Please enter "yes" or "no".');
    }
  }

  static int getIntegerInput(String prompt, {int? min, int? max}) {
    while (true) {
      final input = getUserInput(prompt);

      try {
        final number = int.parse(input);

        if (min != null && number < min) {
          print('Number must be at least $min.');
          continue;
        }

        if (max != null && number > max) {
          print('Number must be at most $max.');
          continue;
        }

        return number;
      } catch (e) {
        print('Please enter a valid integer.');
      }
    }
  }

  static double getDoubleInput(String prompt, {double? min, double? max}) {
    while (true) {
      final input = getUserInput(prompt);

      try {
        final number = double.parse(input);

        if (min != null && number < min) {
          print('Number must be at least $min.');
          continue;
        }

        if (max != null && number > max) {
          print('Number must be at most $max.');
          continue;
        }

        return number;
      } catch (e) {
        print('Please enter a valid number.');
      }
    }
  }

  static String getChoice(String prompt, List<String> validChoices) {
    while (true) {
      final input = getUserInput(prompt).toLowerCase();

      if (validChoices.map((choice) => choice.toLowerCase()).contains(input)) {
        return input;
      }

      print('Please choose from: ${validChoices.join(', ')}');
    }
  }

  static List<String> getCommaSeparatedIds(String prompt) {
    while (true) {
      final input = getUserInput(prompt);
      final ids = input
          .split(',')
          .map((id) => id.trim())
          .where((id) => id.isNotEmpty)
          .toList();

      if (ids.isNotEmpty) {
        return ids;
      }

      print('Please enter at least one valid ID.');
    }
  }

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isValidName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegex.hasMatch(name) && name.trim().isNotEmpty;
  }

  static String getValidName(String prompt) {
    while (true) {
      final name = getUserInput(prompt);

      if (isValidName(name)) {
        return name;
      }

      print('Name should contain only letters and spaces.');
    }
  }

  static String displayMenuAndGetChoice(List<String> menuItems, String prompt) {
    print('');
    for (int i = 0; i < menuItems.length; i++) {
      print('${i + 1}. ${menuItems[i]}');
    }

    final choice = getIntegerInput(prompt, min: 1, max: menuItems.length);
    return choice.toString();
  }

  static void pauseForUser([String message = 'Press Enter to continue...']) {
    stdout.write(message);
    stdin.readLineSync();
  }

  static void clearScreen() {
    if (Platform.isWindows) {
      Process.runSync('cls', [], runInShell: true);
    } else {
      Process.runSync('clear', [], runInShell: true);
    }
  }
}
