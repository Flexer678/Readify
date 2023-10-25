class DetailedBookModel {
  late String title;
  late String image;
  late String authors;
  late String download;
  late String description;
  late String pages;
  late String id;

  DetailedBookModel(
      {required this.image,
      required this.authors,
      required this.title,
      required this.description,
      required this.download,
      required this.pages,
      required this.id});

  factory DetailedBookModel.dbooks(Map<String, dynamic> json) {
    return DetailedBookModel(
        image: json["image"],
        authors: json["authors"],
        title: json["title"],
        pages: json["pages"],
        id: json['id'],
        download: json['download'],
        description: json["description"]);
  }

  factory DetailedBookModel.libgen(Map<String, dynamic> json) {
    return DetailedBookModel(
      title: json['title'],
      authors: json["author"],
      image: json["image"],
      pages: json['pages'],
      description: json['details'],
      id: json['id'],
      download: json['download'],
    );
  }
  factory DetailedBookModel.libgenFic(Map<String, dynamic> json) {
    return DetailedBookModel(
      title: json['title'],
      authors: json["author"],
      image: json["image"],
      pages: "unable to determine",
      description: json['description'],
      id: json['id'],
      download: json['download'],
    );
  }
}
