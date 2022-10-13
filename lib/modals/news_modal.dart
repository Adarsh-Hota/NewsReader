class NewsModal {
  final String author;
  final String title;
  final String description;
  final String img;
  final String date;
  final String url;

  NewsModal(
      this.author, this.title, this.description, this.img, this.date, this.url);

  NewsModal.fromJson(Map<String, dynamic> json)
      : author = json['author'] ?? '',
        title = json['title'] ?? '',
        description = json['description'] ?? '',
        img = json['urlToImage'] ?? '',
        date = json['publishedAt'] ?? '',
        url = json['url'] ?? '';
}
