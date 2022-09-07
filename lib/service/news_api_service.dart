import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class NewsApiService {

  Future<List<Articles>> fetchNewsData() async {
    List<Articles> newsList = [];
    var link = Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=475875bf058e40f4b806ac3235a8dcaf&sortBy=popularity&pageSize=5");

    var responce = await http.get(link);
    var data = jsonDecode(responce.body);
    Articles articles;
    for (var i in data["articles"]) {
      articles = Articles.fromJson(i);
      newsList.add(articles);
    }
    return newsList;
  }
}
