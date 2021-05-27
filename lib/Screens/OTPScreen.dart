import 'package:cowinbooking/NetworkCalls.dart';
import 'package:cowinbooking/Screens/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormState> _formmob = GlobalKey<FormState>();
  final GlobalKey<FormState> _formotp = GlobalKey<FormState>();
  bool submitted = false;
  late String number;
  late String otp;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: _size.width * 0.8,
            child: Form(
              key: _formmob,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text("+91"),
                  ),
                  SizedBox(
                    width: _size.width * 0.6,
                    child: TextFormField(
                      validator: (inp) {
                        if (inp!.isEmpty) return "Number can't be empty";
                        if (inp.length < 10) return "Phone Number is too short";
                        return null;
                      },
                      onSaved: (inp) {
                        number = inp!;
                      },
                      decoration: InputDecoration(
                        helperText: "Phone Number",
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (_formmob.currentState!.validate()) {
                              _formmob.currentState!.save();
                              Response response =
                                  await NetworkCalls.getOTP(number);
                              setState(() {
                                submitted = true;
                              });
                            }
                          },
                          icon: Icon(Icons.arrow_forward_sharp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          (submitted) ? CircularProgressIndicator() : Container(),
          IgnorePointer(
            ignoring: !submitted,
            child: SizedBox(
              width: _size.width * 0.8,
              child: Form(
                key: _formotp,
                child: TextFormField(
                  validator: (inp) {
                    if (inp!.isEmpty) return "OTP cant be empty";
                    return null;
                  },
                  onSaved: (inp) {
                    otp = inp!;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter OTP",
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                if (_formotp.currentState!.validate()) {
                  _formotp.currentState!.save();
                  Response response = await NetworkCalls.validateOTP(otp);
                  if (response.statusCode == 200) Get.to(() => MainScreen());
                }
              },
              icon: Icon(Icons.arrow_forward_sharp),
              label: Text("Submit")),
          Container(),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  submitted = false;
                  _formmob.currentState!.reset();
                  _formotp.currentState!.reset();
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                });
              },
              child: Text("Clear All"))
        ],
      ),
    );
  }
}
