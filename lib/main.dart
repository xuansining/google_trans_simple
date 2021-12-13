import 'package:flutter/material.dart';
import 'package:google_translate/db/words_dao.dart';
import 'package:google_translate/index_page.dart';
import 'package:google_translate/pages/start_page.dart';
import 'package:google_translate/pages/word_collection.dart';
import 'package:flutter/services.dart';
import 'db/database.dart';
import 'pages/start_page.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "index": (context) => IndexPage(),
        "collection": (context) => WordCollection()
      },
      debugShowCheckedModeBanner: false,
      title: 'Google_translate',
      home: StartPage(),
    );
  }
}
