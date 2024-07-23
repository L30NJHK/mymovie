import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/category_model.dart';
import '../models/recommendation_model.dart';
import '../models/popular_model.dart';
import '../models/search_model.dart';
import 'boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  // init variables
  List<CategoryModel> categories = [];
  List<RecommendationModel> recommendations = [];
  List<PopularMoviesModel> popularMovies = [];
  Box<SearchQuery>? searchBox;

  // controler for input text / search query
  final TextEditingController searchController = TextEditingController();

// populate lists  - rplace iwth db later

  void _getInitialInfo() {
    categories = CategoryModel.getCateories();
    recommendations = RecommendationModel.getRecommendations();
    popularMovies = PopularMoviesModel.getPopularMovies();
  }

// save query string to hive
  void saveSearchQuery(String query) {
    final newQuery = SearchQuery()..query = query;
    final box = Boxes.getSearchs();

    // testing - too many searchs dispalyed
    if (box.length > 5) {
      box.clear();
    }
    box.add(newQuery);
    // searchBox?.add(newQuery);
    searchController.clear();
    // print(searchBox?.get(0));
    // print(newQuery.query);
  }

// App bar to display title of app
  // @override
  AppBar appBar() {
    return AppBar(
      title: const Text(
        'MyMovie',
        style: TextStyle(
            color: Color.fromARGB(255, 29, 26, 26),
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 137, 131, 131),
    );
  }

// main app  container with layout of sections and spacers
  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color.fromARGB(255, 46, 42, 42),
      body: ListView(children: [
        _searchField(),
        const SizedBox(
          height: 37,
        ),
        _categoriesSection(),
        const SizedBox(
          height: 37,
        ),
        _recommendationSection(),
        const SizedBox(
          height: 37,
        ),
        _popularSection(),
        const SizedBox(
          height: 37,
        ),
        // start of saved searches
        _savedSearchs(),
        const SizedBox(
          height: 37,
        ),
      ]),
    );
  }

  // function listens for changes to database search box and updates list
// if any changes have been saved
  Column _savedSearchs() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recent Search History',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        // Builtin function to listen for changes - fetch search results form hive
        // reverse order of list so that most recent search is shown frist
        ValueListenableBuilder(
            valueListenable: Boxes.getSearchs().listenable(),
            builder: (context, box, _) {
              // convert searchs to list
              final searchs = box.values.toList();
              // iterate over list for length of list
              return ListView.builder(
                itemCount: searchs.length,
                shrinkWrap: true,
                reverse: true,
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  // display query text
                  return ListTile(
                    title: Text(
                      searchs[index].query,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                },
              );
            }),
      ],
    );
  }

  Container _searchField() {
    // final myController = TextEditingController();
    // display input form with custom controller to capture input
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
            hintText: 'Search Movies',
            hintStyle: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            filled: true,
            fillColor: const Color.fromARGB(255, 140, 134, 134),
            // call save function when icon is clicked and search text has been enetred

            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  saveSearchQuery(searchController.text);
                  // print(searchController.text);
                }
              },
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }

  Column _categoriesSection() {
    // display film categories -make selectable - to do
    // dispaly horizontally
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Film Catagories',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ), // add spacing
        const SizedBox(
          height: 15,
        ),
        // display list of hardcoded categaroies

        SizedBox(
          height: 140,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(
              width: 5,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: const Color(0xff92A3FD).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15)),
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(categories[index].iconPath),
                      ),
                    ),
                    Text(categories[index].name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 244, 242, 242),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Column _recommendationSection() {
    // hardcoded recommendations
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Movie Recomendations',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),

        // for each box iterate over length of recommendations
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemCount: recommendations.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 15, right: 15),
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: recommendations[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15)),
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: SvgPicture.asset(recommendations[index].iconPath),
                    ),
                    Column(
                      children: [
                        Text(recommendations[index].name,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 247, 246, 249),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        // use string literal to dispaly movie information
                        Text(
                          '${recommendations[index].year} | ${recommendations[index].duration} | ${recommendations[index].rating}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 202, 199, 200),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Container(
                      width: 130,
                      height: 45,
                      decoration: BoxDecoration(
                          color: const Color(0xff9DCEFF),
                          borderRadius: BorderRadius.circular(40)),

                      // button not implemented onPress to fetch ombd data
                      child: const Center(
                        child: Text(
                          'View',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Column _popularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Popular Right Now',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ListView.separated(
          itemCount: popularMovies.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(
            height: 25,
          ),
          padding: const EdgeInsets.only(left: 15, right: 15),
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // get svgs - replace with poster jpg
                children: [
                  SvgPicture.asset(
                    popularMovies[index].iconPath,
                    width: 65,
                    height: 65,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        popularMovies[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      // use string literal to dispaly movie information
                      Text(
                        '${popularMovies[index].year} | ${popularMovies[index].duration} | ${popularMovies[index].rating}',
                        style: const TextStyle(
                            color: Color(0xff7B6F72),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
