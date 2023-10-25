import 'dart:convert';

import 'package:readify/models/book_models.dart';

import 'package:http/http.dart' as http;
import 'package:readify/models/detailed_book_model.dart';

class LibgenFic {
  static String Url =
      "https://us-central1-readify-21f57.cloudfunctions.net/app";

  Future getinitial(String title) async {
    final uri = Uri.parse("${Url}/");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      //print(response.body);
      return response.body;
    } else {
      return [];
    }
  }

  static Future<List<BookModel>> getSearch(String title, int page) async {
    final uri = Uri.parse("${Url}/search/${title}/page=${page}/");
    List<BookModel>? Results = [];
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        res['books'].forEach((ele) => {Results.add(BookModel.libgenFic(ele))});

        return await Results;
      } else {
        print("error at libgenFIc ");
        return [];
      }
    } catch (e) {
      print("error at libgenFIc 1 ");
      return [];
    }
  }

  static Future<DetailedBookModel> getDetails(String urlNumber) async {
    DetailedBookModel detailResults = DetailedBookModel(
        image: "",
        authors: "",
        title: "",
        description: "",
        download: "",
        pages: "",
        id: urlNumber);
    //https: //us-central1-readify-21f57.cloudfunctions.net/app/details/url_number=80769812FFDB2D716E2E4E4597D51875

    final uri = Uri.parse("${Url}/details/url_number=${urlNumber}");

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        //unable to transfer the details

        DetailedBookModel detailResults =
            DetailedBookModel.libgenFic(res['book']);

        return detailResults;
      } else {
        print("error at libgenfic details");
        return detailResults;
      }
    } catch (e) {
      print("error at libgenfic details1");
      return detailResults;
    }
  }
}
