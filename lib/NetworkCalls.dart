import 'dart:convert';
import 'dart:io';

import 'package:cowinbooking/Metadata.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NetworkCalls {
  // ignore: non_constant_identifier_names
  static final String otp_url =
      "https://cdn-api.co-vin.in/api/v2/auth/generateMobileOTP";
  static final String otp_val =
      "https://cdn-api.co-vin.in/api/v2/auth/validateMobileOtp";
  static final String benef =
      "https://cdn-api.co-vin.in/api/v2/appointment/beneficiaries";
  static final String pinSearch = "";
  static final String states =
      "https://cdn-api.co-vin.in/api/v2/admin/location/states";
  static final String districts =
      "https://cdn-api.co-vin.in/api/v2/admin/location/districts/";

  static final String calendar_pincode_url =
      "https://cdn-api.co-vin.in/api/v2/appointment/sessions/calendarByPin?pincode={0}&date={1}";

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

  static Future<Map> getStates() async {
    Map<String, String>? headers = {
      'origin': 'https://selfregistration.cowin.gov.in/',
      'referer': 'https://selfregistration.cowin.gov.in/',
    };
    http.Response response =
        await http.get(Uri.parse(states), headers: headers);
    return jsonDecode(response.body);
  }

  static Future<Map> getDistrict(int id) async {
    Map<String, String>? headers = {
      'origin': 'https://selfregistration.cowin.gov.in/',
      'referer': 'https://selfregistration.cowin.gov.in/',
    };
    http.Response response =
        await http.get(Uri.parse(districts + id.toString()), headers: headers);
    return jsonDecode(response.body);
  }

  static String encodeMap(Map data) {
    return data.keys.map((key) => "${Uri.encodeComponent(key)}=${Uri.encodeComponent(data[key])}").join("&");
  }

  static Future<Map> getCenter(var pincode,
      {var date, var vaccine}) async{
    Map<String, String>? headers = {
      'origin': 'https://selfregistration.cowin.gov.in/',
      'referer': 'https://selfregistration.cowin.gov.in/',
      'Content-Type': 'application/json'
    };

    if(date==null){
      var date_now = DateTime.now();
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      date = formatter.format(date_now);
    }

    Map queryParameters = {};

    queryParameters['pincode'] = pincode;
    queryParameters['date'] = date;
    if (vaccine!=null) queryParameters['vaccine'] = vaccine;

    String url = calendar_pincode_url;
    url = url.replaceAll("{0}", pincode);
    url = url.replaceAll("{1}", date);
    print(url);

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    print(response.body);
    return jsonDecode(response.body);
  }
}
