import 'package:flutter/material.dart';

class pinCodeSearch extends StatefulWidget {
  @override
  _pinCodeSearchState createState() => _pinCodeSearchState();
}

class _pinCodeSearchState extends State<pinCodeSearch> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool isValidPinCode(String pinCode){
    if(pinCode.length!=6 || pinCode[0]=='0') return false;
    return true;
  }

  var pincodeWidgets = <Widget>[];
  var pincode="";

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search by Pincode"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: _size.height * 0.2,
                child: Form(
                  key: _form,
                  child: SizedBox(
                      width: _size.width * 0.7,
                      child: TextFormField(
                        onSaved: (inp) {
                          pincode = inp!;
                        },
                        validator: (inp){
                          if(!isValidPinCode(inp!)) return "PinCode is not valid";
                          return null;
                        },
                        maxLength: 6,
                        decoration: InputDecoration(hintText: "Enter Pincode",
                        suffixIcon: IconButton(onPressed: (){
                          if (_form.currentState!.validate()) {
                            _form.currentState!.save();
                            pincodeWidgets.add(Text(pincode));
                          }
                        }, icon: Icon(Icons.add_box))),
                      )),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(itemCount: pincodeWidgets.length, itemBuilder: (BuildContext context,int index){
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(2),
                  child: Center(
                      child: pincodeWidgets[index],
                  ),
                );
              },),
            ),
          ],
        ),
      ),
    );
  }
}
