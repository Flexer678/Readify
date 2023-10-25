import 'package:flutter/material.dart';
import 'package:readify/pages/homepage.dart';
import 'package:readify/pages/profile.dart';
import 'package:readify/pages/search.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [HomePage(), Search(), Person()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
          items: [
            const BottomNavigationBarItem(
                label: "Library", icon: Icon(Icons.library_books)),
            BottomNavigationBarItem(
                label: "Search", icon: const Icon(Icons.search)),
            BottomNavigationBarItem(label: "Acccount", icon: Icon(Icons.person))
          ]),
      body: pages[index],
    );
  }
}
