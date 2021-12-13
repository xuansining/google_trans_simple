import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

// or new Dio with a BaseOptions instance.
var options = BaseOptions(
  // baseUrl: 'https://www.xx.com/api',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = Dio(options);
final String testUrl =
    'http://api.fanyi.baidu.com/api/trans/vip/translate?q=apple&from=en&to=zh&appid=2015063000000001&salt=1435660288&sign=f89f9594663708c1605f3d736d01d2d4';
final String baseUrl = 'https://fanyi-api.baidu.com/api/trans/vip/translate';
//为了安全，不展示秘钥
final String appId = 'xxxxxx';
final String myId = 'xxxxxx';
String slat = '';
void getSalt() {
  slat = Random().nextInt(2000).toString();
  print(slat);
}

String getAppId(String appId, String q, String myId) {
  print(appId + q + slat + myId);
  return appId + q + slat + myId;
}

//appid+q+salt+密钥的MD5值
String getSign(String mappId) {
  var content = new Utf8Encoder().convert(mappId);
  return md5.convert(content).toString();
}

//'from': 'en', 'to': 'zh','appid':'xx','salt':'xxx'
Future<Response> getDateByWord(String word, String from, String to) async {
  Response<Map<String, dynamic>> response;
  getSalt();

  String sign = getSign(getAppId(appId, word, myId));
  print('sign' + sign);
  Map<String, dynamic> params = {
    'q': word,
    'from': from,
    'to': to,
    'appid': appId,
    'salt': slat,
    'sign': sign
  };
  response = await dio.get(baseUrl, queryParameters: params);

  // print(response.data);
  return response;
}
