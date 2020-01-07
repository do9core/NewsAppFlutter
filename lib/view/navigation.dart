import 'package:flutter/material.dart';
import 'package:news_application/view/favourite.dart';
import 'package:news_application/view/headline.dart';
import 'package:news_application/view/search.dart';

const RootPath = '/';
const FavouritePath = '/favourites';
const SearchPath = '/search';

// ignore: non_constant_identifier_names
final Routes = {
  RootPath: (BuildContext context) => HeadlinePage(),
  FavouritePath: (BuildContext context) => FavouritePage(),
  SearchPath: (BuildContext context) => SearchPage()
};
