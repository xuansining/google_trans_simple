// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WordsDao? _wordsDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `WordDbModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `rootWord` TEXT NOT NULL, `subWord` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WordsDao get wordsDao {
    return _wordsDaoInstance ??= _$WordsDao(database, changeListener);
  }
}

class _$WordsDao extends WordsDao {
  _$WordsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _wordDbModelInsertionAdapter = InsertionAdapter(
            database,
            'WordDbModel',
            (WordDbModel item) => <String, Object?>{
                  'id': item.id,
                  'rootWord': item.rootWord,
                  'subWord': item.subWord
                }),
        _wordDbModelDeletionAdapter = DeletionAdapter(
            database,
            'WordDbModel',
            ['id'],
            (WordDbModel item) => <String, Object?>{
                  'id': item.id,
                  'rootWord': item.rootWord,
                  'subWord': item.subWord
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WordDbModel> _wordDbModelInsertionAdapter;

  final DeletionAdapter<WordDbModel> _wordDbModelDeletionAdapter;

  @override
  Future<List<WordDbModel>> findAllWords() async {
    return _queryAdapter.queryList('SELECT * FROM WordDbModel',
        mapper: (Map<String, Object?> row) => WordDbModel(
            row['rootWord'] as String,
            row['subWord'] as String,
            row['id'] as int?));
  }

  @override
  Future<void> insertWord(WordDbModel word) async {
    await _wordDbModelInsertionAdapter.insert(word, OnConflictStrategy.abort);
  }

  @override
  Future<void> remove(WordDbModel word) async {
    await _wordDbModelDeletionAdapter.delete(word);
  }
}
