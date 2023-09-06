import 'dart:io';

import 'package:chaleno/chaleno.dart';
import 'package:web_scraper/web_scraper.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

//Map<String,dynamic>
Future ibgen(String title) async {
  print("hello");
  final webScraper = WebScraper('http://libgen.rs');
  String category = "title";
  if (await webScraper.loadWebPage(
      '/search.php?req=${title}&open=0&res=200&view=detailed&phrase=1&column=${category}')) {
    List<Map<String, dynamic>> document = webScraper.getElement(
        "body > table:nth-child(8) > tbody:nth-child(2) > tr:nth-child(2) > td:nth-child(1) > a:nth-child(1) > img:nth-child(1)"
        "",
        [
          "src",
          "img",
          "title",
        ]);

    print(document);
    bool isloading = true;
    return [document, "hello"];
  }
}

Future bgen(String title) async {
  String category = "title";
  var url = Uri.http(
      'http://libgen.rs/search.php?req=${title}&open=0&res=200&view=detailed&phrase=1&column=${category}');
  http.Response response = await http.get(url);
  dom.Document html = dom.Document.html(response.body);

  if (response.statusCode == 200) {
    String data = response.body;
    return "stuff";
  } else {
    return 'failed';
  }
}

Future Libgen(String title) async {
  print('runn');
  final uri = Uri.parse("http://libgen.rs");
  final response = await http.get(uri);
  print('working');
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    return [];
  }
}
