```dart
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

Future<dynamic> fetchData() async {
  int retryCount = 0;
  const maxRetries = 3;
  const backoffFactor = 2;

  while (retryCount < maxRetries) {
    try {
      final response = await http.get(Uri.parse('https://api.example.com/data'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is Map && jsonData.containsKey('data')) {
          return jsonData['data'];
        } else {
          throw Exception('Invalid JSON structure: Missing or incorrect data key');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } on FormatException catch (e) {
      print('Error: Invalid JSON format: $e');
      return null; // Or handle as appropiate
    } on Exception catch (e) {
      print('Error: $e - Retry attempt ${retryCount + 1} of $maxRetries');
      await Future.delayed(Duration(seconds: pow(backoffFactor, retryCount).toInt()));
      retryCount++;
    }
  }
  throw Exception('Failed to load data after multiple retries');
}
```