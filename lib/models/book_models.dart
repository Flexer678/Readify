class BookModel {
  late String title;
  late String image;
  late String url;
  late String authors;

  BookModel(
      {required this.image,
      required this.authors,
      required this.title,
      required this.url});

  BookModel.dbooks(Map<String, dynamic> json) {
    title = json['title'];
    authors = json['title'];
    image = json['image'];
    url = json['url'];
  }

  BookModel.libgen(Map<String, dynamic> json) {
    title = json[''];
  }
}
