import 'package:flutter/material.dart';
import 'package:news_application/view/navigation.dart';

import 'app_states.dart';

void main() => runApp(MyApp());

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
