
class Headline {
  String status;
  int totalResults;
  List<Article> articles;

  Headline({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory Headline.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final totalResults = json['totalResults'];
    final articles = new List<Article>();
    if (json['articles'] != null) {
      json['articles'].forEach((v) {
        articles.add(Article.fromJson(v));
      });
    }
    return Headline(status: status, totalResults: totalResults, articles: articles);
  }
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content']
    );
  }
}

class Source {
  String id;
  String name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name']
    );
  }
}
