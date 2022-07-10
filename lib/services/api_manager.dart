import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/constants/strings.dart';
import 'package:news/models/news_info.dart';

class API_manager{

  Future<Welcome> getNews() async{

    var respnse = await http.get(Strings.news_url);
    var newsModel = null;

    try {
      if (respnse.statusCode == 200) {
        var jsonstring = respnse.body;
        var jsonmap = json.decode(jsonstring);
        newsModel = Welcome.fromJson(jsonmap);
      }
    }
    catch(e) {
      return newsModel;
    }

    return newsModel;
  }
}