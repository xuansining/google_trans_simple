import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:google_translate/db/database.dart';
import 'package:google_translate/db/db_manager.dart';

import 'package:google_translate/db/word_db_model.dart';

class Item {
  String title;
  String subTitle;
  bool isCollection;
  Item(this.title, this.subTitle, this.isCollection);
}

class ItemModel extends ChangeNotifier {
  List<WordDbModel> wordList = [];
  int _id = 4;
  bool _isCollection = false;
  String _currentWord = '';
  String _currentTo = '';
  final List<Item> _items = [];
  UnmodifiableListView<Item> get item => UnmodifiableListView(_items);
  get currentWord => this._currentWord;
  List<Item> get wordItems => this._items;
  bool get isCollection => this._isCollection;

  void doCollection(bool flag) {
    this._isCollection = flag;
    _items.clear();
    _items.add(Item(this._currentWord, this._currentTo, this._isCollection));
    notifyListeners();
  }

  void setCurrentWord(String word) {
    this._currentWord = word;
  }

  Future<String> insert() async {
    return await FDbManager.insertWords(
        WordDbModel(this._currentWord, this._currentTo, null));
  }

  Future<void> getAll() async {
    var list = await FDbManager.getWords();
    wordList = list;
  }

  void setIsCollection(bool isCollection) {
    this._isCollection = isCollection;
  }

  void updateItems(String from, String to) {
    this._currentTo = to;
    this._currentWord = from;
    _items.clear();
    setIsCollection(false);
    _items.add(Item(from, to, this._isCollection));
    notifyListeners();
  }

  Future<void> initDb() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final wordsDao = database.wordsDao;
  }
}
