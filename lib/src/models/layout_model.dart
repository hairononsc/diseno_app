import 'package:diseno_app/src/labs/slideshow_page.dart';
import 'package:flutter/material.dart';

class LayoutModel with ChangeNotifier {
  Widget _currentPage = SlideShowPage();

  set currentPage(Widget page) {
    this._currentPage = page;
    notifyListeners();
  }

  Widget get currentPage => this._currentPage;
  // double _currentPage = 0;

  // double get currentPage => this._currentPage;

  // set currentPage(double currentPage) {
  //   this._currentPage = currentPage;
  //   notifyListeners();
  // }
}
