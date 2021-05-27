import 'dart:convert';
import 'dart:io';

import 'package:cowinbooking/Metadata.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class NetworkCalls {
  // ignore: non_constant_identifier_names
  static final String otp_url =
      "https://cdn-api.co-vin.in/api/v2/auth/generateMobileOTP";
  static final String otp_val =
      "https://cdn-api.co-vin.in/api/v2/auth/validateMobileOtp";
  static final String benef =
      "https://cdn-api.co-vin.in/api/v2/appointment/beneficiaries";
  static final MetaData meta = Get.put(MetaData());

  static Future<http.Response> getOTP(String number) async {
    Map mobile = {};
    mobile['secret'] =
        "U2FsdGVkX1/JL3gfdhdxA7QIYB9xxdXiQd1Mz4frcbUdcoA+q44cPIOD+EZ/mQTKKRQ5jWl6KDmqgDbdgfTadA==";
    mobile["mobile"] = number;
    http.Response response = await http.post(Uri.parse(otp_url),
        body: jsonEncode(mobile),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    meta.txnId = jsonDecode(response.body)['txnId'];
    return response;
  }

  static Future<http.Response> validateOTP(String otp) async {
    Map<String, String>? headers = {
      'origin': 'https://selfregistration.cowin.gov.in/',
      'referer': 'https://selfregistration.cowin.gov.in/',
      'Content-Type': 'application/json'
    };
    Map body = {};
    body['otp'] = sha256.convert((utf8.encode(otp))).toString();
    body['txnId'] = meta.txnId;
    // print(jsonEncode(body));
    http.Response response = await http.post(Uri.parse(otp_val),
        body: jsonEncode(body), headers: headers);
    meta.token = jsonDecode(response.body)['token'];
    return response;
  }

  static Future<Map> getBenefeciaries() async {
    Map<String, String>? headers = {
      'origin': 'https://selfregistration.cowin.gov.in/',
      'referer': 'https://selfregistration.cowin.gov.in/',
      'Authorization': "Bearer " + meta.token!
    };
    http.Response response = await http.get(Uri.parse(benef), headers: headers);
    // print(response.body);
    return jsonDecode(response.body);
  }
}
