import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:github_stats/model/userSearchModel.dart';
import 'package:http/http.dart' as http;

class Api extends ChangeNotifier {
  final String key;
  Api({this.key});
  List<Item> userFetchResult = [];

  Future getUserInfo() async {
    const String url = "https://api.github.com/users/vijayshankarrealdeal";
    final responseData = await http.get(url);
    if (responseData.statusCode == 200) {
      print(responseData.body);
    } else {
      print(responseData.statusCode);
    }
  }

  Future<void> getSearchUserInfo(String username) async {
    userFetchResult.isEmpty ? print(1) : userFetchResult.clear();
    if (username.isEmpty) {
      throw "Please provide a name";
    } else {
      final String url = "https://api.github.com/search/users?q=$username&per_page=3";
      final responseData = await http.get(url);
      if (responseData.statusCode == 200) {
        final extractedUser =
            jsonDecode(responseData.body) as Map<String, dynamic>;
        final x = UserSearchModel.fromJson(extractedUser);
        userFetchResult.clear();
        x.items.forEach((element) {
          userFetchResult.add(element);
        });
        print(userFetchResult.length);
      } else {
        throw responseData.statusCode;
      }
    }
    notifyListeners();
  }
}
