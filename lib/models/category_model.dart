class CategoryModel {
  String name;
  String iconPath;

  CategoryModel({
    required this.name,
    required this.iconPath,
  });

// Film Category model

  static List<CategoryModel> getCateories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
      name: 'Action',
      iconPath: 'assets/icons/action.svg',
    ));

    categories.add(CategoryModel(
      name: 'Crime',
      iconPath: 'assets/icons/crime.svg',
    ));

    categories.add(CategoryModel(
      name: 'Sci-fi',
      iconPath: 'assets/icons/sci-fi.svg',
    ));

    categories.add(CategoryModel(
      name: 'Drama',
      iconPath: 'assets/icons/drama.svg',
    ));

    categories.add(CategoryModel(
      name: 'Kids',
      iconPath: 'assets/icons/kids.svg',
    ));

    categories.add(CategoryModel(
      name: 'Horror',
      iconPath: 'assets/icons/horror.svg',
    ));

    categories.add(CategoryModel(
      name: 'Romance',
      iconPath: 'assets/icons/romance.svg',
    ));

    return categories;
  }
}
