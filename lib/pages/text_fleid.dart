import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_translate/model/item_model.dart';
import 'package:google_translate/model/language.dart';
import 'package:provider/provider.dart';
import 'icon_page.dart';
import '../Http/api.dart';

class TextFleid extends StatefulWidget {
  TextFleid({Key? key}) : super(key: key);

  @override
  _TextFleidState createState() => _TextFleidState();
}

class _TextFleidState extends State<TextFleid> {
  Response? response;
  String? result;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(0),
      child: Container(
        height: 150.0,
        child: Column(
          children: [InputField(test: result), IconDemo()],
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  String? test;
  InputField({Key? key, this.test}) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState(test: test);
}

class _InputFieldState extends State<InputField> {
  String? test;
  Duration durationTime = Duration(milliseconds: 1500);
  Timer? timer;
  late TextEditingController _unameController;
  late FocusNode focusNode;
  _InputFieldState({this.test});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode = FocusNode();

// 监听焦点变化
    focusNode.addListener(() {
      print(focusNode.hasFocus);
    });

    _unameController = TextEditingController();
    _unameController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemModel>(builder: (context, ItemModel itemModel, child) {
      return Expanded(
          child: Container(
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, bottom: 20.0, top: 2.0),
              child: TextField(
                autofocus: false,
                focusNode: focusNode,
                controller: _unameController,
                onChanged: (e) {
                  setState(() {
                    timer?.cancel();
                    timer = new Timer(durationTime, () {
                      if (e.trim() != '') {
                        getDateByWord(e, Languages.selectedFromLanguage,
                                Languages.selectedToLanguage)
                            .then((value) => {
                                  if (value.data['trans_result'] != null)
                                    itemModel.setCurrentWord(e),
                                  itemModel.updateItems(
                                      e, value.data['trans_result'][0]['dst'])
                                });
                      }
                    });
                  });
                },
                onTap: () {},
                decoration: InputDecoration(
                    labelText: test,
                    hintText: '点按即可输入文本',
                    border: InputBorder.none),
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                maxLines: 999,
                cursorColor: Colors.grey[500],
                cursorWidth: 2.0,
              )));
    });

    ;
  }
}
