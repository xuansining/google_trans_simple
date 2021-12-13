import 'package:flutter/material.dart';
import 'package:google_translate/db/db_manager.dart';
import 'package:google_translate/db/word_db_model.dart';
import 'package:google_translate/model/expand_list.dart';

import 'drawer.dart';

class WordCollection extends StatefulWidget {
  WordCollection({Key? key}) : super(key: key);

  @override
  _WordCollectionState createState() => _WordCollectionState();
}

class _WordCollectionState extends State<WordCollection> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerView(),
        appBar: AppBar(
          title: Text('收藏夹'),
          centerTitle: true,
          // leading: Icon(Icons.menu),
        ),
        body: FutureBuilder<List<ExpandMap>>(
          builder: (BuildContext context,
              AsyncSnapshot<List<ExpandMap>> asyncSnapShot) {
            switch (asyncSnapShot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
              case ConnectionState.done:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return _ExpandTile(asyncSnapShot, index);
                  },
                  itemCount: asyncSnapShot.data?.length,
                );

              case ConnectionState.none:
              default:
                return Center(
                  child: Text('请求失败'),
                );
              // TODO: Handle this case.

            }
          },
          future: FDbManager.getExpandableList(),
        ));
  }

  Widget _ExpandTile(AsyncSnapshot<List<ExpandMap>> asyncSnapShot, int index) {
    return Card(
        child: ExpansionTile(
            iconColor: Colors.blue[600],
            subtitle: Text(
              '语种:${asyncSnapShot.data?[index].wList.length}',
              style: TextStyle(color: Colors.grey),
            ),
            title: Text(
              asyncSnapShot.data![index].root,
              style: Theme.of(context).textTheme.headline5,
            ),
            children: _displayList(asyncSnapShot.data![index].wList)));
  }

  List<Widget> _displayList(List<WordDbModel> list) {
    List<Widget> wList = [];
    list.forEach((element) {
      ListTile lt = ListTile(
        title: Text(element.rootWord),
        subtitle: Text(element.subWord),
        trailing: IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              FDbManager.removeWords(element);
            });
          },
        ),
      );
      wList.add(lt);
    });
    return wList;
  }
}
