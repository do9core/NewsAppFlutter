import 'package:flutter/material.dart';

extension StringExt on String {
  String capitalize() => (this != null && this.length > 1)
      ? this[0].toUpperCase() + this.substring(1)
      : this != null ? this.toUpperCase() : null;
}

void showSnackbar(BuildContext context, String text) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
}