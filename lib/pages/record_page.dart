import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:google_translate/components/g_toast.dart';
import 'package:google_translate/db/db_manager.dart';

import 'package:google_translate/model/item_model.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RecordingT extends StatefulWidget {
  _RecordingTState createState() => _RecordingTState();
}

class _RecordingTState extends State<RecordingT> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemModel>(builder: (context, itemModel, child) {
      return Expanded(
        child: ListView.builder(
          itemCount: itemModel.wordItems.length,
          itemBuilder: (context, index) {
            return _displayList(index, itemModel);
          },
        ),
      );
    });
  }

  Widget _displayList(int index, ItemModel itemModel) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 2.0,
        left: 2.0,
        right: 2.0,
      ),
      child: Card(
        margin: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 15.0,
            top: 15.0,
            bottom: 15.0,
          ),
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _flexible(index, itemModel),
              _collection(index, itemModel)
            ],
          ),
        ),
      ),
    );
  }

  Widget _flexible(int index, ItemModel itemModel) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            itemModel.wordItems[index].title,
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            itemModel.wordItems[index].subTitle,
            style: TextStyle(color: Colors.grey[600], fontSize: 18.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _collection(int index, ItemModel itemModel) {
    return IconButton(
      onPressed: () async {
        if (!itemModel.isCollection) {
          //星星不亮
          // itemModel.doCollection();
          String flag = await itemModel.insert();
          if (flag == 'NOSAVED') {
            showToast('收藏成功');
            itemModel.doCollection(true); //把isColletion变为true
            return;
          } else {
            showToast('你已经收藏过了');
            return;
          }
        }

        if (itemModel.isCollection) {
          //星星亮

          showToast('取消收藏');
          await FDbManager.removeLastWord();
          itemModel.doCollection(false);
        }
      },
      icon: Icon(
        itemModel.wordItems[index].isCollection
            ? Icons.star
            : Icons.star_border,
        size: 25.0,
        color: itemModel.wordItems[index].isCollection
            ? Colors.yellow[600]
            : Colors.grey[700],
      ),
    );
  }
}
