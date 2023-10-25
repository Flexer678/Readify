import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readify/models/book_models.dart';
import 'package:readify/scraper/dbooks_api.dart';
import 'package:readify/scraper/libgen_api.dart';
import 'package:readify/scraper/libgenfic_api.dart';

class ProviderHandler extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<BookModel> SavedBooks = [];
  var detaildata;
  get allItems => null;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(BookModel Savedbooks) {
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  Future<void> loadDetails(urls, type) async {
    Map<String, Future> typeCalls = {
      "dbooks": Dbooks.getDetails(urls),
      "libgenFic": LibgenFic.getDetails(urls),
      "libgen": Libgen.getDetailed(urls)
    };
    //detaildata = await typeCalls[type];
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
