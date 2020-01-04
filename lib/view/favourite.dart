import 'package:flutter/material.dart';
import 'package:news_application/data/local/database.dart';
import 'package:news_application/data/model.dart';

class FavouritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  Future<List<Article>> articles;

  @override
  void initState() {
    super.initState();
    articles = favourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourites')),
      body: FutureBuilder(
        future: articles,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildErrorPage(snapshot.error);
          }
          return snapshot.hasData
              ? _buildList(snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildErrorPage(Object error) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(Icons.error),
          Text(error.toString()),
        ],
      ),
    );
  }

  Widget _buildList(List<Article> listData) {
    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, position) {
        final itemData = listData[position];
        return _FavouriteItem(
          itemData,
          () => _onRemoveArticle(itemData),
        );
      },
    );
  }

  _onRemoveArticle(Article article) async {
    await article.delete();
    setState(() {
      articles = favourites();
    });
  }
}

class _FavouriteItem extends StatelessWidget {
  final Article article;
  final VoidCallback onRemoved;

  _FavouriteItem(this.article, this.onRemoved);

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      title: Text(
        article.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        article.description ?? '',
        maxLines: 3,
        overflow: TextOverflow.fade,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onRemoved,
      ),
    );
    return Card(child: tile);
  }
}
