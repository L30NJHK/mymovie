import 'package:flutter/material.dart';

class RecommendationModel {
  String name;
  String iconPath;
  String year;
  String duration;
  String rating;
  Color boxColor;

// model to hold recommended movies - to be completed
  RecommendationModel({
    required this.name,
    required this.iconPath,
    required this.year,
    required this.duration,
    required this.rating,
    required this.boxColor,
  });

// populate recommendations - replace with api call to ombd
  static List<RecommendationModel> getRecommendations() {
    List<RecommendationModel> recommendations = [];

    recommendations.add(RecommendationModel(
        name: 'The Martian',
        iconPath: 'assets/icons/astronaut.svg',
        year: '2015',
        duration: '144 min',
        rating: 'PG-13',
        boxColor: const Color(0xff9DCEFF)));

    recommendations.add(RecommendationModel(
        name: 'Moon',
        iconPath: 'assets/icons/moon.svg',
        year: '2009',
        duration: '97 min',
        rating: 'R',
        boxColor: const Color(0xffEEA4CE)));

    recommendations.add(RecommendationModel(
        name: 'E.T.',
        iconPath: 'assets/icons/et.svg',
        year: '1982',
        duration: '114 min',
        rating: 'PG',
        boxColor: const Color(0xff9DCEFF)));

    return recommendations;
  }
}
