import 'package:flutter/material.dart';
import 'package:readify/scraper/dbooks_api.dart';
import 'package:readify/scraper/libgen_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var stuff;

  void dd(stufdf) {
    setState(() {
      stuff = stufdf;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('${Libgen("stuff")}')));
  }
}
