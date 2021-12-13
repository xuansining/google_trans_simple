import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_translate/model/item_model.dart';
import 'package:provider/provider.dart';
import 'components/g_toast.dart';
import 'pages/drawer.dart';
import 'pages/body_page.dart';
import 'pages/text_fleid.dart';
import 'pages/record_page.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            drawer: DrawerView(),
            appBar: AppBar(
              actions: [],
              title: Text('谷歌翻译simple'),
              // leading: IconButton(icon: Icon(Icons.menu), onPressed: () {})
            ),
            body: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => ItemModel()),
              ],
              child: Column(
                children: [
                  BodyPage(),
                  TextFleid(),
                  SizedBox(
                    height: 20,
                  ),
                  RecordingT(),
                ],
              ),
            )),
        onWillPop: () async {
          bool? flag = await showDeleteConfirmDialog1(context);
          return flag! ? true : false;
        });
  }

  Future<bool?> showDeleteConfirmDialog1(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要退出App吗?"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            TextButton(
              child: Text("残忍离开"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
