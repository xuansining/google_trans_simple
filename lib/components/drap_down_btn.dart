import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_translate/Http/api.dart';
import 'package:google_translate/const/lang.dart';
import 'package:google_translate/model/item_model.dart';
import 'package:google_translate/model/language.dart';
import 'package:provider/provider.dart';

class LangDropDownBtn extends StatefulWidget {
  String flag;
  String defaultValue;
  LangDropDownBtn(this.flag, this.defaultValue, {Key? key}) : super(key: key);

  @override
  _LangDropDownBtnState createState() =>
      _LangDropDownBtnState(flag, defaultValue);
}

class _LangDropDownBtnState extends State<LangDropDownBtn> {
  Duration durationTime = Duration(seconds: 1);
  Timer? timer;
  String flag;
  String defaultValue;
  Color _primaryColor = Colors.blue[600]!;
  List<DropdownMenuItem<String>> langItems = [];
  String _selectedItem = '';
  _LangDropDownBtnState(this.flag, this.defaultValue);
  @override
  void initState() {
    // TODO: implement initState
    this._selectedItem = defaultValue;
    langItems.addAll(langMap.map((value) {
      return DropdownMenuItem(
          value: value['value'],
          child: Text(
            value['lang']!,
            style: TextStyle(color: Colors.blue[600]),
          ));
    }).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemModel>(builder: (context, ItemModel itemModel, child) {
      return DropdownButton(
        elevation: 9,
        items: langItems,
        value: _selectedItem,
        underline: Container(color: Colors.transparent),
        onChanged: (selected) {
          setState(() {
            this._selectedItem = selected.toString();

            if (flag == 'to') {
              Languages.selectedToLanguage = selected.toString();
            } else {
              Languages.selectedFromLanguage = selected.toString();
            }
            if (itemModel.currentWord != '') {
              timer?.cancel();
              timer = new Timer(durationTime, () {
                getDateByWord(
                        itemModel.currentWord,
                        Languages.selectedFromLanguage,
                        Languages.selectedToLanguage)
                    .then((value) => {
                          if (value.data['trans_result'] != null)
                            itemModel.updateItems(itemModel.currentWord,
                                value.data['trans_result'][0]['dst'])
                        });
              });
            }
          });
        },
        icon: ImageIcon(
          AssetImage('images/spinner_blue.9.png'),
          color: this._primaryColor,
        ),
      );
    });
  }
}
