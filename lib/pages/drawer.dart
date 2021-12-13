import 'package:flutter/material.dart';
import 'package:google_translate/index_page.dart';
import 'package:google_translate/pages/word_collection.dart';

class DrawerView extends StatefulWidget {
  DrawerView({Key? key}) : super(key: key);

  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  bool indexSelected = true;
  bool collectionSelected = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('xuanxuan'),
            accountEmail: Text('test@123.com'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'images/bg_account_switcher.png',
                    ),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            selected: indexSelected,
            title: Text(
              '首页',
            ),
            leading: Icon(
              Icons.home,
            ),
            onTap: () {
              indexSelected = !indexSelected;
              Navigator.of(context).pushReplacementNamed('index');
            },
          ),
          ListTile(
            selected: collectionSelected,
            title: Text('翻译收藏'),
            leading: Icon(
              Icons.stars,
            ),
            onTap: () {
              collectionSelected = !collectionSelected;
              Navigator.of(context).popAndPushNamed('collection');
            },
          ),
          ListTile(
            title: Text('离线翻译'),
            leading: Icon(
              Icons.translate,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('设置'),
            leading: Icon(
              Icons.settings,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
