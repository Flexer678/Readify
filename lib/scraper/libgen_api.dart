import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future Libgen(String title) async {
  final uri =
      Uri.parse("https://us-central1-readify-21f57.cloudfunctions.net/app");
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    return [];
  }
}

Future LibgenFic(String title) async {
  try {
    final uri =
        Uri.parse("https://us-central1-readify-21f57.cloudfunctions.net/app");
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
