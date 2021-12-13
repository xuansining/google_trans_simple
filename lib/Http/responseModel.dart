import 'dart:html';

class ErrorModel {
  String? error_code;
  String? error_msg;
  ErrorModel(this.error_code, this.error_msg);
}

class SuccessModel {
  String from;
  String to;
  List<Result> trans_result;
  SuccessModel(this.from, this.to, this.trans_result);
}

class Result {
  String src;
  String dst;
  Result(this.src, this.dst);
}
