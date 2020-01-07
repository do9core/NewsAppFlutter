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
    return Headline(
      status: json['status'],
      totalResults: json['totalResults'],
      articles:
          List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );
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
      content: json['content'],
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
      name: json['name'],
    );
  }
}

class Everything {
  final String status;
  final int totalResults;
  final List<Article> articles;

  Everything({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory Everything.fromJson(Map<String, dynamic> json) {
    return Everything(
      status: json["status"],
      totalResults: json["totalResults"],
      articles:
          List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );
  }
}

enum Country { China, America }

extension CountryEx on Country {
  String code() {
    switch (this) {
      case Country.China:
        return 'cn';
      case Country.America:
        return 'us';
      default:
        throw ArgumentError.value(this, 'Unknown enum value.');
    }
  }
}

enum Category {
  Business,
  Entertainment,
  General,
  Health,
  Science,
  Sports,
  Technology
}

extension CategoryEx on Category {
  String name() {
    switch (this) {
      case Category.Business:
        return 'business';
      case Category.Entertainment:
        return 'entertainment';
      case Category.General:
        return 'general';
      case Category.Health:
        return 'health';
      case Category.Science:
        return 'science';
      case Category.Sports:
        return 'sports';
      case Category.Technology:
        return 'technology';
      default:
        throw ArgumentError.value(this, 'Unknown enum value');
    }
  }
}
