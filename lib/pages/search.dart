import 'package:flutter/material.dart';

import 'package:readify/pages/detailed_page.dart';
import 'package:readify/pages/gridview_books.dart';
import 'package:readify/scraper/dbooks_api.dart';
import 'package:readify/scraper/libgen_api.dart';
import 'package:readify/scraper/libgenfic_api.dart';
import 'package:readify/utils/booktype.dart';
import 'package:readify/widgets/book_view.dart';
import 'package:readify/widgets/input.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

var searchVar = "";

class _SearchState extends State<Search> {
  String? downloadurl;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          SizedBox(
            height: 60,
          ),
          SearchInput(
            controller: searchController,
            text: "search a book",
            type: TextInputType.text,
            run: () {
              setState(() {
                FocusScope.of(context).unfocus();
                searchVar = searchController.text;
              });
            },
          ),
          Column(
            children: [
              Title("LibgenFiction", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => GridviewBooks(
                          title: searchVar,
                          future: BookType.bookTypes['libgenfic']!)),
                );
              }),
              BookResults(LibgenFic.getSearch(searchVar, 1),
                  BookType.bookTypes['libgenfic']!),
              Title("Libgen", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => GridviewBooks(
                          title: searchVar,
                          future: BookType.bookTypes['libgen']!)),
                );
              }),
              BookResults(Libgen.getSearch(searchVar, 1),
                  BookType.bookTypes['libgen']!),
              Title("dbooks", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => GridviewBooks(
                          title: searchVar,
                          future: BookType.bookTypes['dbooks']!)),
                );
              }),
              BookResults(
                  Dbooks.getSearch(searchVar), BookType.bookTypes['dbooks']!),
            ],
          )
        ]),
      ),
    );
  }

  Container BookResults(
    Future func,
    String type,
  ) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 250,
      child: Container(
        child: FutureBuilder(
          future: func,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data;
              return data == []
                  ? Center(
                      child: Text("No data available"),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, index) {
                        downloadurl = data[index].url;
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailedPage(
                                    url: data[index].url, type: type)));
                          },
                          onLongPress: () {},
                          child: BookView(
                              authors: data[index].authors,
                              image: data[index].image,
                              id: data[index].url,
                              title: data[index].title),
                        );
                      });
            } else {
              return Center(
                child: Text("no data available"),
              );
            }
          },
        ),
      ),
    );
  }

  Row Title(String Title, Function onpressed) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Title,
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
            onPressed: () {
              onpressed();
            },
            icon: Icon(Icons.arrow_forward))
      ],
    );
  }
}
