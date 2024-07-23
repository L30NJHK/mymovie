import 'package:hive/hive.dart';

part 'search_model.g.dart';

// Simple model to hold user search string
//so it can be written and read from hive

@HiveType(typeId: 0)
class SearchQuery extends HiveObject {
  @HiveField(0)
  late String query;
}
