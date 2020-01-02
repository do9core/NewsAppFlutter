import 'package:flutter/material.dart';
import 'package:news_application/view/navigation.dart';
import 'package:news_application/util/util.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/remote/api.dart';
import '../app_states.dart';
import '../data/model.dart';

class HeadlinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Headlines'),
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.pushNamed(context, FavouritesPath);
                },
              ),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: Categories
                .map((category) => Tab(text: category.capitalize()))
                .toList(),
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.search),
            onPressed: () => _navigateToSearch(context),
          ),
        ),
        body: TabBarView(
          children:
          Categories.map((category) => HeadlineList(category)).toList(),
        ),
      ),
    );
  }

  _navigateToSearch(BuildContext context) {
    // TODO: navigate to next page
    showSnackbar(context, 'Not implement.');
  }
}

class HeadlineList extends StatefulWidget {
  final String category;
  HeadlineList(this.category);
  @override
  State<StatefulWidget> createState() => _HeadlineListState();
}

class _HeadlineListState extends State<HeadlineList> with AutomaticKeepAliveClientMixin {
  Future<Headline> headline;

  @override
  void initState() {
    super.initState();
    headline = fetchHeadline(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: headline,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          showSnackbar(context, snapshot.error.toString());
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

  void _openArticle(BuildContext context) async {
    if (await canLaunch(article.url)) {
      await launch(article.url);
    } else {
      showSnackbar(context, 'Could not launch the url.');
    }
  }

  void _favouriteArticle(BuildContext context) {
    favourites.add(article);
    showSnackbar(context, 'Article saved in favourites!');
  }

  void _shareArticle(BuildContext context) {
    // TODO: implement share
    showSnackbar(context, 'Not implement');
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
