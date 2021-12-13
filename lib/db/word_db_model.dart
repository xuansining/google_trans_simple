import 'package:floor/floor.dart';

@entity
class WordDbModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String rootWord;
  final String subWord;
  WordDbModel(this.rootWord, this.subWord, this.id);
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'rootWord': rootWord,
  //     'subWord': subWord,
  //   };
  // }

  // @override
  // String toString() {
  //   return 'Word: {id:$id,rootWord:$rootWord,subWord:$subWord}';
  // }
}
