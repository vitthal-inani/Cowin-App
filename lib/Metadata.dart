import 'package:get/get.dart';

class MetaData extends GetxController {
  String? _txnId;
  String? _mobile;
  String? _token;
  List? _bens=[];
  List<String>? _pincodesList=[];

  String? get txnId => _txnId;

  String? get mobile => _mobile;

  String? get token => _token;
  List? get bens => _bens;


  List get pincodesList => _pincodesList!;

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

  void addPincode(String? pincode){
    _pincodesList!.add(pincode!);
  }
  void removePincode(String? pincode){
    _pincodesList!.remove(pincode!);
  }
}
