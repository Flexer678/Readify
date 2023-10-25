import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:readify/models/detailed_book_model.dart';
import 'package:readify/provider/notification_provider.dart';
import 'package:readify/provider/provider.dart';
import 'package:readify/scraper/libgen_api.dart';
import 'package:readify/scraper/libgenfic_api.dart';
import 'package:readify/scraper/dbooks_api.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:readify/utils/colors.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailedPage extends StatefulWidget {
  DetailedPage({super.key, required this.url, required this.type});
  String url;
  String type;

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  //future wont load

  Future<String?> loaddownload(String id, String Widgettype) async {
    Map<String, dynamic> typeCallss = {
      "dbooks": "",
      "libgenfic": "",
      "libgen": ""
    };
    return typeCallss[Widgettype];
  }

  @override
  @override
  Widget build(BuildContext context) {
    Map<String, Future<DetailedBookModel>> typeCallss = {
      "dbooks": Dbooks.getDetails(widget.url),
      "libgenfic": LibgenFic.getDetails(widget.url),
      "libgen": Libgen.getDetailed(widget.url)
    };

    print(widget.url);
    return Scaffold(
      body: detailbuilder(typeCallss[widget.type]!, widget.type),
    );
  }

  FutureBuilder<Object?> detailbuilder(Future future, String type) {
    String? downloadUrl;
    var _progress;

    return FutureBuilder(
      future: future,

      //BuildContext context,AsyncSnapshot snapshot
      //note when using the parameters its compulsoury to add the parameter tyes or else things wont work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data;

          return Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 300,
                      child: Row(children: [
                        Expanded(
                          flex: 1,
                          child: CachedNetworkImage(
                            imageUrl: data!.image! == ''
                                ? "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"
                                : data!.image!,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  child: Text(
                                    "${data!.title}",
                                    style: TextStyle(fontSize: 25),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  child: Text(
                                    "author(s):  ${data!.authors!}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                    height: 30,
                                    child: Text(
                                      "pages:       ${data!.title!}",
                                      overflow: TextOverflow.ellipsis,
                                    ))
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 300,
                      child: Container(
                        child: Text("${data!.description!}"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text("url Link"),
                          Text(data!.download),
                        ],
                      ),
                    ),
                    Container(
                      child: Center(
                          child: _progress != null
                              ? const CircularProgressIndicator()
                              : TextButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.green,
                                      textStyle:
                                          TextStyle(color: AppColors.white)),
                                  child: Text("download document"),
                                  onPressed: () async {
                                    if (type == "libgen") {
                                      downloadUrl =
                                          await Libgen.getDownload(data!.id)
                                              as String?;
                                    } else {
                                      downloadUrl = data!.download;
                                    }

                                    Fluttertoast.showToast(
                                        msg: 'downloading ${data!.title}',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    FileDownloader.downloadFile(
                                      url: '$downloadUrl',
                                      downloadDestination:
                                          DownloadDestinations.appFiles,
                                      notificationType: NotificationType.all,

                                      name:
                                          "${data!.title}", //THE FILE NAME AFTER DOWNLOADING,
                                      onProgress:
                                          (String? fileName, double? progress) {
                                        print(
                                            'FILE fileName HAS PROGRESS $progress');
                                      },
                                      onDownloadCompleted: (String path) {
                                        Fluttertoast.showToast(
                                            msg: 'downloaded ${data!.title}',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Fluttertoast.showToast(
                                            msg: 'downloading to  $path',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        print('FILE DOWNLOADED TO PATH: $path');
                                      },
                                      onDownloadError: (String error) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'unable to download ${data!.title}',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        print('DOWNLOAD ERROR: $error');
                                      },
                                    );
                                  },
                                )),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Text("something whent wrong please check your Network"),
          );
        }
      },
    );
  }
}
