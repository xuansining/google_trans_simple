import 'package:google_translate/db/word_db_model.dart';
import 'package:google_translate/db/words_dao.dart';
import 'package:google_translate/model/expand_list.dart';

import 'database.dart';

class FDbManager {
  static database() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('words.db').build();
    final wDao = database.wordsDao;
    return wDao;
  }

  static Future<String> insertWords(WordDbModel dbModel) async {
    bool isHasCollection;
    final WordsDao wDao = await database();
    List<WordDbModel> list = await getWords();
    isHasCollection = list.any((element) =>
        element.subWord == dbModel.subWord &&
        element.rootWord == dbModel.rootWord);
    if (isHasCollection) {
      return 'SAVED';
    } else {
      await wDao.insertWord(dbModel);
      return 'NOSAVED';
    }
  }

  static Future<List<WordDbModel>> getWords() async {
    final WordsDao wDao = await database();
    List<WordDbModel> list = await wDao.findAllWords();
    print('getWords执行了');
    return list;
  }

  static Future<List<ExpandMap>> getExpandableList() async {
    List<WordDbModel> list = await getWords();
    Map<String, List<WordDbModel>> map = {};
    list.forEach((element) {
      final key = element.rootWord;
      if (map.containsKey(key)) {
        map[key]?.add(element);
      } else {
        List<WordDbModel> newList = [];
        newList.add(element);
        map[key] = newList;
      }
    });
    List<ExpandMap> finalList = [];
    map.forEach((key, value) {
      finalList.add(ExpandMap(key, value));
    });
    return finalList;
  }

  static Future<void> removeWords(WordDbModel wd) async {
    final WordsDao wDao = await database();
    wDao.remove(wd);
    print('remove执行了');
  }

  static Future<void> removeLastWord() async {
    List<WordDbModel> list = await getWords();
    await removeWords(list.last);
  }
}
