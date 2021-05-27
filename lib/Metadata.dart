import 'package:get/get.dart';

class MetaData extends GetxController {
  String? _txnId;
  String? _mobile;
  String? _token;
  List? _bens=[];

  String? get txnId => _txnId;

  String? get mobile => _mobile;

  String? get token => _token;
  List? get bens => _bens;

  set txnId(String? number) {
    _txnId = number;
  }

  set token(String? number) {
    _token = number;
  }

  set mobile(String? number) {
    _mobile = number;
  }

  void addBen(String? number){
    _bens!.add(number);
  }
  void removeBen(String? number){
    _bens!.remove(number);
  }
}
