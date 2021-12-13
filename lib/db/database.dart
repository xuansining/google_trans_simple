// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:google_translate/db/word_db_model.dart';
import 'package:google_translate/db/words_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
// the generated code will be there
part 'database.g.dart';

@Database(version: 1, entities: [WordDbModel])
abstract class AppDatabase extends FloorDatabase {
  WordsDao get wordsDao;
}
