import 'package:flutter/cupertino.dart';

class LanguageModel extends ChangeNotifier {
  String _selectedFromLanguage = 'en';
  String _selectedToLanguage = 'zh';
  get fromLanguage => this._selectedFromLanguage;
  get toLanguage => this._selectedToLanguage;
  void setFromLanguage(String lang) {
    this._selectedFromLanguage = lang;
    notifyListeners();
  }

  void setToLanguage(String lang) {
    this._selectedToLanguage = lang;
    notifyListeners();
  }
}

class Languages {
  static String currentWord = '';
  static String selectedFromLanguage = 'en';
  static String selectedToLanguage = 'zh';
}
