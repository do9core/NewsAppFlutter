import 'package:flutter/material.dart';
import 'package:news_application/view/navigation.dart';

void main() => runApp(MyApp());

const AppName = 'News Application';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppName,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: RootPath,
      routes: Routes,
    );
  }
}
