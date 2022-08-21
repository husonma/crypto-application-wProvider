import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/coin_data_page_model.dart';

class ApiHandler {
  final String _apiKey = "75554f28a89363dc990ba501a1aedea08136b2da";
  final String _apiBaseUrl = "https://api.nomics.com/v1/currencies/ticker";

  Future<List<CoinList>?> getCurrencies() async {
    final _url = _apiBaseUrl + "?key=$_apiKey";

    var response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      var json = response.body;
      return coinListFromJson(json);
    }
  }
}
