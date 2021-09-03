class Headline {
  String? status;
  int? totalResults;
  List<Article>? articles;

  Headline(
    this.articles,
    {
    this.status,
    this.totalResults,
  });

  factory Headline.fromJson(Map<String, dynamic> json) {
    return Headline(
      List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
      status: json['status'],
      totalResults: json['totalResults'],
    );
  }
}

class Article {
  Source? source;
  String? author;
  String title;
  String description;
  String url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article(
    this.title,
    this.description,
    this.url,
    {
    this.source,
    this.author,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      json['title'],
      json['description'],
      json['url'],
      source: Source.fromJson(json['source']),
      author: json['author'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

class Source {
  String? id;
  String? name;

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
  final String? status;
  final int? totalResults;
  final List<Article> articles;

  Everything(
    this.articles,{
    this.status,
    this.totalResults,
  });

  factory Everything.fromJson(Map<String, dynamic> json) {
    return Everything(
      List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
      status: json["status"],
      totalResults: json["totalResults"],
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
