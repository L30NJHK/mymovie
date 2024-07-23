import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home.dart';
import './models/search_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initiase Hive database
  await Hive.initFlutter();

  // Register custom hive adaptor

  Hive.registerAdapter(SearchQueryAdapter());
  //prepare database for use to hold search queries
  await Hive.openBox<SearchQuery>('searchBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Dosis'),
        home: const HomePage());
  }
}
