import 'package:flutter/material.dart';
import 'package:news_application/data/model/models.dart';
import 'package:news_application/data/remote/api.dart';

const SearchTitle = 'Search';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sliverBody = NestedScrollView(
      headerSliverBuilder: (context, value) {
        return <Widget>[
          SliverAppBar(
            title: Text(SearchTitle),
            floating: true,
          ),
        ];
      },
      body: Column(
        children: <Widget>[
          SearchBox(),
          SearchResult(null),
        ],
      ),
    );
    return Scaffold(
      body: sliverBody,
    );
  }
}

class SearchBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
        ],
      ),
    );
  }
}

class SearchResult extends StatefulWidget {
  final String query;

  SearchResult(this.query);

  @override
  State<StatefulWidget> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Future<Everything> _everything;

  @override
  void initState() {
    super.initState();
    if (widget.query.isNotEmpty) {
      _everything = fetchEverything(widget.query);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.query.isNotEmpty) {
      return FutureBuilder(
        future: _everything,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _errorPage(snapshot.error);
          } else {
            return snapshot.hasData ? _resultList(snapshot.data) : _loading();
          }
        },
      );
    } else {
      return Center(
        child: Text('Search everything.'),
      );
    }
  }

  Widget _errorPage(dynamic errorData) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(Icons.error),
          Text(errorData.toString()),
        ],
      ),
    );
  }

  Widget _resultList(Everything everything) {
    final articles = everything.articles;
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, position) => ListTile(
        title: Text(
          articles[position].title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          articles[position].description,
          maxLines: 3,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
