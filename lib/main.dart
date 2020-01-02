import 'package:flutter/material.dart';

import 'headline.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Application',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HeadlinePage(),
    );
  }
}
