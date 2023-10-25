import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readify/models/book_models.dart';
import 'package:readify/models/detailed_book_model.dart';

class Dbooks {
  static final String url = "https://www.dbooks.org/api/";
  static Future<List<BookModel>> getSearch(String title) async {
    List<BookModel>? Results = [];
    try {
      final uri = Uri.parse("${url}search/${title}");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> res = await json.decode(response.body);
        //print(res);
        res['books'].forEach((ele) => {Results.add(BookModel.dbooks(ele))});

        //print(Results);
        return Results;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<DetailedBookModel> getDetails(String id) async {
    DetailedBookModel detailResults = DetailedBookModel(
        image: "",
        authors: "",
        title: "",
        description: "",
        download: "",
        pages: "",
        id: id);
    try {
      final uri = Uri.parse("$url/book/${id}");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> res = await json.decode(response.body);

        detailResults = DetailedBookModel.dbooks(res);
        return detailResults;
      } else {
        print('error at dbooksdetails');
        return detailResults;
      }
    } catch (e) {
      print('error at dbooksdetails1');
      return detailResults;
    }
  }
}
