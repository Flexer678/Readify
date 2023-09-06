import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future dbooks(String title) async {
  final uri = Uri.parse("https://www.dbooks.org/api/search/${title}");
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return [];
  }
}
