import 'package:flutter/foundation.dart';

enum SearchBy { PRODUCTS, RESTAURANTS }

class AppProvider extends ChangeNotifier {
  bool isLoading = false;
  SearchBy searchBy = SearchBy.PRODUCTS;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeSearchBy({SearchBy newSearchBy}) {
    searchBy = newSearchBy;
    notifyListeners();
  }
}
