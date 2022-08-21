import 'package:flutter/material.dart';
import '../Model/coin_data_page_model.dart';
import '../Service/coin_data_page_service.dart';

class CoinDataPageProvider extends ChangeNotifier {
  List<CoinList>? foundcoins = [];

  fetchCoins() async {
    try {
      final apicoins = await ApiHandler().getCurrencies();
      foundcoins = apicoins;
    } catch (e) {}
    notifyListeners();
  }

  void filterCoin(String coinName) {
    List<CoinList>? results = [];
    if (coinName.isEmpty) {
      results = foundcoins;
    } else {
      results = foundcoins
          ?.where((element) => element.id
              .toLowerCase()
              .toString()
              .contains(coinName.toLowerCase()))
          .toList();
    }
    foundcoins = results;
    notifyListeners();
  }

  /*UnmodifiableListView<CoinList> get foundCoins {
    return UnmodifiableListView(_foundcoins);
  }

  set foundcoins(List<CoinList> foundCoins) {
    _foundcoins = foundCoins;
    notifyListeners();
  }*/
}


/* 
class DataController extends GetxController {
  List<CoinList> currencyList = List<CoinList>.empty(growable: true).obs;
  var foundcoins = <CoinList>[].obs;

  @override
  void onInit() {
    getcurrency();
    super.onInit();
    foundcoins.value = currencyList;
  }

  void getcurrency() async {
    try {
      var data = await ApiHandler().getCurrencies();
      currencyList.assignAll(data);
    } on Exception catch (e) {}
  }

  @override
  void onClose() {}
  void filterCoin(String coinName) {
    List<CoinList> results = [];
    if (coinName.isEmpty) {
      results = currencyList;
    } else {
      results = currencyList
          .where((element) => element.id
              .toLowerCase()
              .toString()
              .contains(coinName.toLowerCase()))
          .toList();
    }
    foundcoins.value = results;
  }
}

  */