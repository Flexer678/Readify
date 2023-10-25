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
    authors = json['authors'];
    image = json['image'];
    url = json['id'];
  }

  BookModel.libgen(Map<String, dynamic> json) {
    title = json['title'];
    authors = json["author"];
    image = json["img"];
    url = json["url_number"];
  }

  BookModel.libgenFic(Map<String, dynamic> json) {
    title = json['title'];
    authors = json["author"];
    image = json["img"];
    url = json["url_number"];
  }
}
