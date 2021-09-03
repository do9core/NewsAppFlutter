import 'package:flutter/material.dart';

extension StringEx on String {
  String capitalize() {
    if (isEmpty) {
      return '';
    }
    if (length == 1) {
      return this[0].toUpperCase();
    }
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}

switchSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}
