import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' as isolate;
import 'package:http/http.dart' as http;

import '../model/models.dart';

const authority = 'newsapi.org';
const headLine = '/v2/top-headlines';
const everything = 'v2/everything';
const _apiKey = 'b21b3035a5884eceba9d84597683b7b0';

Future<Headline> fetchHeadline(
  Category category, {
  Country country = Country.America,
  String sources,
  String q,
  num pageSize,
  num page,
}) async {
  final query = {
    'country': country.code(),
    'category': category.name(),
    'sources': sources,
    'q': q,
    'pageSize': pageSize,
    'page': page,
  };
  final uri = Uri.https(authority, headLine, query);
  final resp =
      await http.get(uri, headers: {HttpHeaders.authorizationHeader: _apiKey});
  return isolate.compute(parseHeadline, resp.body);
}

Headline parseHeadline(String response) {
  final parsed = json.decode(response);
  return Headline.fromJson(parsed);
}

Future<Everything> fetchEverything(
  String q, {
  String qInTitle,
  String sources,
  String domains,
  String excludeDomains,
  String from,
  String to,
  String language,
  String sortBy,
  num pageSize,
  num page,
}) async {
  final query = {
    'q': q,
    'qInTitle': qInTitle,
    'sources': sources,
    'domains': domains,
    'excludeDomains': excludeDomains,
    'from': from,
    'to': to,
    'language': language,
    'sortBy': sortBy,
    'pageSize': pageSize,
    'page': page,
  };
  final uri = Uri.https(authority, everything, query);
  final resp =
      await http.get(uri, headers: {HttpHeaders.authorizationHeader: _apiKey});
  return isolate.compute(parseEverything, resp.body);
}

Everything parseEverything(String response) {
  final parsed = json.decode(response);
  return Everything.fromJson(parsed);
}
