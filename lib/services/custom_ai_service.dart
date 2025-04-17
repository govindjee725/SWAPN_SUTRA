// lib/services/custom_ai_service.dart

import 'dart:convert'; // for jsonDecode
import 'package:flutter/services.dart' show rootBundle; // for loading assets

class CustomAIService {
  List<dynamic> _data = [];

  /// Loads JSON file from assets
  Future<void> loadJson() async {
    final String response = await rootBundle.loadString('assets/custom_ai_data.json');
    _data = jsonDecode(response);
  }

  /// Matches the user's prompt with keywords
  Future<String> matchPrompt(String userPrompt) async {
    int attempts = 0;

    for (var item in _data) {
      attempts++;
      List<dynamic> keywords = item['question_keywords'];
      for (var keyword in keywords) {
        if (userPrompt.toLowerCase().contains(keyword.toLowerCase())) {
          return item['answer'];
        }
      }
      if (attempts >= 100) {
        break;
      }
    }

    return ""; // No match found
  }
}
