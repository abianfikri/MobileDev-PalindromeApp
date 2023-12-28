import 'dart:convert';

import 'package:palindrome_test/model/user_data_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<UserDataList> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://reqres.in/api/users?page=1&per_page=10'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        UserDataList userList = UserDataList.fromJson(jsonResponse);
        return userList;
      } else {
        // Gagal mendapatkan respons, tangani kesalahan dengan melempar Exception
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      // Tangani kesalahan umum
      throw Exception("Error: $error");
    }
  }

  bool isPalindrome(String text) {
    // Remove spaces and convert to lowercase for case-insensitive comparison
    String cleanText = text.replaceAll(" ", "").toLowerCase();

    // Compare the original string with its reverse
    return cleanText == cleanText.split('').reversed.join('');
  }
}
