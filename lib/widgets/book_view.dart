import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

class BookView extends StatelessWidget {
  final String image;
  final String id;
  final String authors;
  final String title;

  const BookView(
      {super.key,
      required this.authors,
      required this.image,
      required this.id,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(193, 75, 62, 62),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: image == ''
                      ? "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"
                      : image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                authors,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10),
              ),
            )
          ],
        ));
  }
}
