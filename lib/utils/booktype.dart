import 'package:readify/scraper/dbooks_api.dart';
import 'package:readify/scraper/libgenfic_api.dart';

class BookType {
  static Map<String, String> bookTypes = {
    "libgen": "libgen",
    "libgenfic": "libgenfic",
    "dbooks": "dbooks"
  };
}
//put that inside the search method