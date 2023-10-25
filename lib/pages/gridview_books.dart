import 'package:flutter/material.dart';
import 'package:readify/models/book_models.dart';
import 'package:readify/models/detailed_book_model.dart';
import 'package:readify/pages/detailed_page.dart';
import 'package:readify/scraper/dbooks_api.dart';
import 'package:readify/scraper/libgen_api.dart';
import 'package:readify/scraper/libgenfic_api.dart';
import 'package:readify/utils/colors.dart';
import 'package:readify/widgets/book_view.dart';

class GridviewBooks extends StatefulWidget {
  String future;
  String title;
  GridviewBooks({super.key, required this.future, required this.title});

  @override
  State<GridviewBooks> createState() => _GridviewBooksState();
}

class _GridviewBooksState extends State<GridviewBooks> {
  int _page = 1;
  @override
  Widget build(BuildContext context) {
    Map<String, Future<List<BookModel>>> _typeCallss = {
      "dbooks": Dbooks.getSearch(widget.title),
      "libgenfic": LibgenFic.getSearch(widget.title, _page),
      "libgen": Libgen.getSearch(widget.title, _page)
    };
    print("the future is ${widget.future} and title is ${widget.title}");
    TextEditingController _controller = TextEditingController();
    _controller.text = _page.toString();
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 70,
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Row(
            children: [
              Text("page: "),
              SizedBox(
                width: 10,
              ),
              Container(
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                        focusColor: AppColors.yellow,
                        iconColor: AppColors.yellow,
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.white)),
                    keyboardType: TextInputType.number,
                  )),
              SizedBox(
                width: 40,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _page = int.parse(_controller.text);
                    });
                  },
                  icon: Icon(Icons.search)),
              SizedBox(
                width: 40,
              ),
              Text(
                'Title:      ${widget.title}',
                style: TextStyle(decoration: TextDecoration.underline),
              )
            ],
          ),
        ),
        Flexible(
          child: FutureBuilder<List<BookModel>>(
            future: _typeCallss[widget.future],
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data;
                return data.length == 0
                    ? Center(
                        child: Text("no data available"),
                      )
                    : GridView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 20,
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailedPage(
                                    url: data[index].url,
                                    type: widget.future)));
                          },
                          child: BookView(
                              authors: data[index].authors,
                              image: data[index].image,
                              id: data[index].url,
                              title: data[index].title),
                        ),
                      );
              } else {
                return Center(
                  child: Text("no data available"),
                );
              }
            },
          ),
        ),
      ],
    ));
  }

  Container othermethod(TextEditingController _controller,
      Map<String, Future<List<BookModel>>> _typeCallss) {
    return Container(
      child: Container(
        width: 200,
        height: 100,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text("page: "),
            Container(
                width: 30,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).unfocus();
                    _page = int.parse(_controller.text);
                  });
                },
                icon: Icon(Icons.search)),
            Text('$_page  ${widget.title}')
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<BookModel>> newMethod(
      Map<String, Future<List<BookModel>>> _typeCallss) {
    return FutureBuilder<List<BookModel>>(
      future: _typeCallss[widget.future],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data;
          return GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7, crossAxisSpacing: 20, crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailedPage(
                        url: data[index].url, type: widget.future)));
              },
              child: BookView(
                  authors: data[index].authors,
                  image: data[index].image,
                  id: data[index].url,
                  title: data[index].title),
            ),
          );
        } else {
          return Center(
            child: Text("no data available"),
          );
        }
      },
    );
  }
}

/*FutureBuilder<List<BookModel>>(
                future: _typeCallss[widget.future],
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    var data = snapshot.data;
                    return GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 20,
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailedPage(
                                  url: data[index].url, type: widget.future)));
                        },
                        child: BookView(
                            authors: data[index].authors,
                            image: data[index].image,
                            id: data[index].url,
                            title: data[index].title),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("no data available"),
                    );
                  }
                },
              ),*/

/*Row(
            children: [
              Text("page: "),
              Container(
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _page = int.parse(_controller.text);
                    });
                  },
                  icon: Icon(Icons.search)),
              Text('$_page  ${widget.title}')
            ],
          ),*/
