class PopularMoviesModel {
  String name;
  String iconPath;
  String year;
  String duration;
  String rating;

  // model to display popular right now movies

  PopularMoviesModel({
    required this.name,
    required this.iconPath,
    required this.year,
    required this.duration,
    required this.rating,
  });

  // populate models with data - replace with db if time

  static List<PopularMoviesModel> getPopularMovies() {
    List<PopularMoviesModel> popularMovies = [];

    popularMovies.add(PopularMoviesModel(
      name: 'Harry Potter and the Deathly Hallows',
      iconPath: 'assets/icons/harry.svg',
      year: '2011',
      duration: '130 mins',
      rating: 'PG-13',
    ));

    popularMovies.add(PopularMoviesModel(
      name: 'Matrix',
      iconPath: 'assets/icons/matrix.svg',
      year: '1993',
      duration: '60 mins',
      rating: 'N/A',
    ));

    return popularMovies;
  }
}
