import 'package:flutter/material.dart';

class StoredBookView extends StatefulWidget {
  const StoredBookView({super.key});

  @override
  State<StoredBookView> createState() => _StoredBookViewState();
}

class _StoredBookViewState extends State<StoredBookView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("bookview"),
    );
  }
}
