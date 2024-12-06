```dart
Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      // Incorrect data handling, assuming JSON response always has a 'data' key
      final jsonData = jsonDecode(response.body)['data'];
      // ... process jsonData ...
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
    // Missing proper error handling and retry mechanism
  }
}
```