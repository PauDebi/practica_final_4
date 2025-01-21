import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;
  
  int get selectedMenuOptGetter => this._selectedMenuOpt;

  set setMenuOpt(int i) {
    this._selectedMenuOpt = i;
    notifyListeners();
  }
}