import 'dart:html';

import 'package:flutter/material.dart';
import 'package:news_application/util/util.dart';
import 'package:news_application/view/navigation.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/local/database.dart';
import '../data/model/models.dart';
import '../data/remote/api.dart';

class HeadlinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            title: Text('Headlines'),
            floating: true,
            snap: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: Category.values
                  .map((category) => Tab(text: category.name().capitalize()))
                  .toList(),
            ),
          ),
        ];
      },
      body: TabBarView(
        children:
            Category.values.map((category) => HeadlineList(category)).toList(),
      ),
    );
    final drawer = Builder(
      builder: (context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(child: Text('News Application')),
            ListTile(
              title: Text('Favourites'),
              leading: Icon(Icons.favorite),
              onTap: () => Navigator.pushNamed(context, FavouritePath),
            ),
            ListTile(
              title: Text('Watch Later'),
              leading: Icon(Icons.watch_later),
              onTap: () {},
            ),
            ListTile(
              title: Text('App Info'),
              leading: Icon(Icons.info),
              onTap: () {},
            )
          ],
        ),
      )
    );
    return DefaultTabController(
      length: Category.values.length,
      child: Scaffold(
        drawer: drawer,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.search),
            onPressed: () => _navigateToSearch(context),
          ),
        ),
        body: page,
      ),
    );
  }

  _navigateToSearch(BuildContext context) {
    Navigator.pushNamed(context, SearchPath);
  }
}

class HeadlineList extends StatefulWidget {
  final Category category;

  HeadlineList(this.category);

  @override
  State<StatefulWidget> createState() => _HeadlineListState();
}

class _HeadlineListState extends State<HeadlineList>
    with AutomaticKeepAliveClientMixin {
  Future<Headline> headline;

  @override
  void initState() {
    super.initState();
    headline = fetchHeadline(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: headline,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.error),
                Text(snapshot.error.toString())
              ],
            ),
          );
        }
        return snapshot.hasData
            ? _buildList(context, snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildList(BuildContext context, Headline data) {
    final articles = data.articles;
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, pos) => _buildItem(context, articles[pos]),
    );
  }

  Widget _buildItem(BuildContext context, Article data) {
    return HeadlineListItem(data);
  }

  @override
  bool get wantKeepAlive => true;
}

class HeadlineListItem extends StatelessWidget {
  final Article article;

  HeadlineListItem(this.article);

  @override
  Widget build(BuildContext context) {
    final popupMenu = PopupMenuButton(
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 0:
            _favouriteArticle(context);
            break;
          case 1:
            _shareArticle(context);
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 0,
          child: Text('Favourite'),
        ),
        const PopupMenuItem(
          value: 1,
          child: Text('Share'),
        )
      ],
    );
    final itemText = ListTile(
      onTap: () => _openArticle(context),
      title: Text(
        article.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        article.description ?? '',
        maxLines: 2,
        overflow: TextOverflow.fade,
      ),
      trailing: popupMenu,
    );
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 80,
            child: _buildImage(),
          ),
          Expanded(
            child: itemText,
          )
        ],
      ),
    );
  }

  _openArticle(BuildContext context) async {
    if (await canLaunch(article.url)) {
      await launch(article.url);
    } else {
      switchSnackbar(context, 'Could not launch the url.');
    }
  }

  _favouriteArticle(BuildContext context) async {
    await article.insert();
    switchSnackbar(context, 'Article saved in favourites!');
  }

  _shareArticle(BuildContext context) async {
    await Share.share('${article.title}(${article.url})');
  }

  Widget _buildImage() {
    return article.urlToImage == null
        ? Image.asset('images/placeholder.gif')
        : FadeInImage.memoryNetwork(
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
            image: article.urlToImage,
          );
  }
}
