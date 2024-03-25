import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp2/models/model.dart';

Future<List<Article>> fetchArticles(String apiKey) async {
  final response = await http.get(
    Uri.parse(
        'https://newsapi.org/v2/everything?q=apple&from=2024-03-24&to=2024-03-24&sortBy=popularity&apiKey=5e7954da5a2446538c722b594e8b5df7'),
  );

  if (response.statusCode == 200) {
    return parseArticles(response.body);
  } else {
    throw Exception('Failed to load articles');
  }
}

List<Article> parseArticles(String responseBody) {
  final parsed = jsonDecode(responseBody)['articles'];
  return parsed.map<Article>((json) => Article.fromJson(json)).toList();
}
