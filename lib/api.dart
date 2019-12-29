import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

const categorys = [
  'business',
  'entertainment',
  'general',
  'health',
  'science',
  'sports',
  'technology'
];
const authority = 'newsapi.org';
const headLine = '/v2/top-headlines';
const _apiKey = '85c9c2cae6de432ca6260a779f955c7c';

Future<Headline> fetchHeadline(String category) async {
  final query = {'country': 'us', 'category': category};
  final uri = Uri.https(authority, headLine, query);
  final resp =
      await http.get(uri, headers: {HttpHeaders.authorizationHeader: _apiKey});
  return compute(parseHeadline, resp.body);
}

Headline parseHeadline(String response) {
  final parsed = json.decode(response);
  return Headline.fromJson(parsed);
}
