import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class dbooks {
  final String url = "https://www.dbooks.org/api/";
  Future getSearch(String title) async {
    try {
      final uri = Uri.parse("${url}search/${title}");
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

  Future getDetails(String title) async {
    try {
      final uri = Uri.parse("book/${title}");
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
}
