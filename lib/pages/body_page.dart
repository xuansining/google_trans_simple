import 'package:flutter/material.dart';
import 'package:google_translate/components/drap_down_btn.dart';

class BodyPage extends StatefulWidget {
  BodyPage({Key? key}) : super(key: key);

  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  String _firstLanguage = '英语';
  String _secondLanguage = '中文(简体)';
  Color _primaryColor = Colors.blue[600]!;
  List<DropdownMenuItem<String>> langItems = [];
  String _selectedItem = "中文(简体)";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.grey[400]!))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Material(
                  child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [LangDropDownBtn('from', 'en')],
            ),
          ))),
          Material(
              child: Icon(
            Icons.compare_arrows,
            color: this._primaryColor,
          )),
          Expanded(
              child: Material(
                  child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [LangDropDownBtn('to', 'zh')],
            ),
          ))),
        ],
      ),
    );
  }
}
