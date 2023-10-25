import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readify/models/book_models.dart';
import 'package:readify/models/detailed_book_model.dart';

class Libgen {
  static String Url =
      "https://us-central1-readify-21f57.cloudfunctions.net/app2";

  Future getinitial() async {
    final uri = Uri.parse("${Url}/");
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<BookModel>> getSearch(String title, int page) async {
    final uri = Uri.parse("${Url}/search/${title}/${page}");

    List<BookModel>? Results = [];
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        res['books'].forEach((ele) => {Results.add(BookModel.libgen(ele))});

        return Results;
      } else {
        print("error at Libgen 1");
        return [];
      }
    } catch (e) {
      print("error at Libgen ");
      return [];
    }
  }

  static Future<DetailedBookModel> getDetailed(String urlNumber) async {
    DetailedBookModel detailResults = DetailedBookModel(
        image: "",
        authors: "",
        title: "",
        description: "",
        download: "",
        pages: "",
        id: urlNumber);
    final uri = Uri.parse("${Url}/details/${urlNumber.substring(1)}");

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        //unable to transfer the details
        //print(res['books']);
        DetailedBookModel detailResults =
            DetailedBookModel.libgen(res['books']);

        return detailResults;
      } else {
        return detailResults;
      }
    } catch (e) {
      return detailResults;
    }
  }

  static Future<String> getDownload(String urlNumber) async {
    final uri = Uri.parse("${Url}/download/${urlNumber}");
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData["download"];
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  static Future getData() async {
    final response = await http.get(Uri.parse(
        "https://us-central1-readify-21f57.cloudfunctions.net/app/search/dart/page=1/"));
    print("Status code is: ${response.statusCode}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      var data = jsonData;

      print(data.length.toString());
      print(data);
      return data;
    }
  }
}
