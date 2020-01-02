import 'package:flutter/material.dart';
import 'package:news_application/view/favourite.dart';
import 'package:news_application/view/headline.dart';

const RootPath = '/';
const FavouritesPath = '/favourites';

// ignore: non_constant_identifier_names
final Routes = {
  RootPath: (BuildContext context) => HeadlinePage(),
  FavouritesPath: (BuildContext context) => FavouritePage(),
};
