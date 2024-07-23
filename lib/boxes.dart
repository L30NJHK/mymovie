// ignore: file_names
import 'package:hive/hive.dart';
import './models/search_model.dart';

// define get function for retrieving search data from hive
class Boxes {
  static Box<SearchQuery> getSearchs() => Hive.box<SearchQuery>('searchBox');
}
