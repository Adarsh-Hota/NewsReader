import 'package:newsreader/modals/news_modal.dart';

class NewsResponse {
  List<NewsModal>? news;
  String? error;

  NewsResponse(this.news, this.error);

  NewsResponse.fromJson(Map<String, dynamic> json) {
    news =
        ((json['articles'] as List).map((e) => NewsModal.fromJson(e))).toList();
    error = '';
  }

  NewsResponse.showError(String errorValue)
      : news = [],
        error = errorValue;
}
