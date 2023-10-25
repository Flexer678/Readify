import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readify/models/book_models.dart';
import 'package:readify/provider/provider.dart';
import 'package:readify/scraper/dbooks_api.dart';
import 'package:readify/scraper/libgen_api.dart';
import 'package:readify/scraper/libgenfic_api.dart';
import 'package:readify/utils/colors.dart';
import 'package:readify/widgets/book_view.dart';
import 'package:readify/widgets/input.dart';

import 'package:readify/widgets/savedbook_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //var res =  dbooks.getSearch("dart");

  //this means it has to return a list

  @override
  Widget build(BuildContext context) {
    List<String> category = [
      "Fruits",
      "Vegetables",
      "Grains",
      "Protein Foods",
      "Dairy",
      "others"
    ];
    int selectedIndex = 0;

    //
    //
    TextEditingController _controller = TextEditingController();
    //
    //
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            SearchInput(
              controller: _controller,
              text: 'search ur books',
              type: TextInputType.text,
              run: () {},
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                    "Nothing here \n wait for the following updates for something to show up"),
              ),
            )
          ],
        ),
      ),
    ));
  }

  GridView ListBooks(ProviderHandler stored) {
    return GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      padding: EdgeInsets.all(20),
      childAspectRatio: 1 / 1.2,
      children:
          List.generate(stored.allItems.length, (index) => StoredBookView()),
    );
  }
}
