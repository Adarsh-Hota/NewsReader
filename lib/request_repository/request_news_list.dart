import 'dart:convert';
import 'package:newsreader/modals/news_list.dart';
import 'package:newsreader/secrets.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  final apiKey = newsApiKey;

  Future<NewsResponse> getNews(String country, String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$apiKey';
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);
      Map<String, dynamic> result = jsonDecode(response.body);
      if (result['status'] == 'ok') {
        return NewsResponse.fromJson(result);
      } else {
        return NewsResponse.showError(result['message']);
      }
    } catch (e) {
      return NewsResponse.showError(e.toString());
    }
  }
}
