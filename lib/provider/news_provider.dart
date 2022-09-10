import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/news_api_service.dart';

class NewsProvider with ChangeNotifier {
  List<Articles> newsList = [];

  Future<List<Articles>> getNewsData(
      {required int page, required String sortBy}) async {
    newsList = await NewsApiService.fetchNewsData(page: page, sortBy: sortBy);
    return newsList;
  }

  Articles sortByDate({required String date}) {
    return newsList.firstWhere((element) => element.publishedAt == date);
  }
}
