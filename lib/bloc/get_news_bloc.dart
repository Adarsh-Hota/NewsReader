import 'package:newsreader/modals/news_list.dart';
import 'package:newsreader/request_repository/request_news_list.dart';
import 'package:rxdart/rxdart.dart';

class GetNewsBloc {
  final NewsRepository newsRepository = NewsRepository();
  final BehaviorSubject<NewsResponse> _subject =
      BehaviorSubject<NewsResponse>();

  BehaviorSubject<NewsResponse> get subject {
    return _subject;
  }

  Future<void> getNews(String country, String category) async {
    NewsResponse newsResponse = await newsRepository.getNews(
        country.toLowerCase(), category.toLowerCase());
    _subject.sink.add(newsResponse);
  }

  dispose() {
    _subject.close();
  }
}
