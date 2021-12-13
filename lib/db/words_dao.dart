import 'package:floor/floor.dart';
import 'package:google_translate/db/word_db_model.dart';

@dao
abstract class WordsDao {
  @Query('SELECT * FROM WordDbModel')
  Future<List<WordDbModel>> findAllWords();

  @insert
  Future<void> insertWord(WordDbModel word);

  @delete
  Future<void> remove(WordDbModel word);
}
