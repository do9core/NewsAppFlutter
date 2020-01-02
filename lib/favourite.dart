import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application/app.dart';
import 'package:news_application/model.dart';

class FavouritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
      itemBuilder: _buildItem,
      itemCount: favourites.length,
    );
    return Scaffold(
      appBar: AppBar(title: Text('Favourites')),
      body: list,
    );
  }

  Widget _buildItem(BuildContext context, num position) {
    final itemData = favourites[position];
    return _FavouriteItem(itemData);
  }
}

class _FavouriteItem extends StatelessWidget {
  final Article article;

  _FavouriteItem(this.article);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        onPressed: _onRemoveFav,
      ),
    );
  }

  _onRemoveFav() {
    favourites.remove(article);
  }
}
