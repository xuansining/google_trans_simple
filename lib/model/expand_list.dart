import 'package:google_translate/db/word_db_model.dart';

class ExpandList {
  List<ExpandMap> eList;
  ExpandList(this.eList);
}

class ExpandMap {
  String root;
  List<WordDbModel> wList;
  ExpandMap(this.root, this.wList);
}
