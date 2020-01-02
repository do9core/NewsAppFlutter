import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application/app_states.dart';
import 'package:news_application/data/model.dart';

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
    return _FavouriteItem(itemData, () => _onRemoveArticle(position));
  }

  _onRemoveArticle(num position) => setState(() {
      favourites.removeAt(position);
  });
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
