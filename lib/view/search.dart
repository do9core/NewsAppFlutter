import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: <Widget>[
          SearchBox()
        ],
      ),
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
    // TODO: implement build
    return null;
  }
}

class SearchResult extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
