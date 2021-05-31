import 'package:flutter/material.dart';
import 'package:cowinbooking/NetworkCalls.dart';
import 'package:cowinbooking/Metadata.dart' as Meta;
import 'package:get/get.dart';

class pinCodeSearch extends StatefulWidget {
  @override
  _pinCodeSearchState createState() => _pinCodeSearchState();
}

class _pinCodeSearchState extends State<pinCodeSearch> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool isValidPinCode(String pinCode) {
    if (pinCode.length != 6 || pinCode[0] == '0') return false;
    return true;
  }

  Meta.MetaData control = Get.put(Meta.MetaData());
  var pincode = "";

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
                        validator: (inp) {
                          if (!isValidPinCode(inp!))
                            return "Pincode is not valid";
                          if (control.pincodesList.contains(inp))
                            return "Pincode already added";
                          return null;
                        },
                        maxLength: 6,
                        decoration: InputDecoration(
                            hintText: "Enter Pincode",
                            counter: Text(""),
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  if (_form.currentState!.validate()) {
                                    setState(() {
                                      _form.currentState!.save();
                                      control.addPincode(pincode);
                                    });
                                    // var response = await NetworkCalls.getCenter(pincode);
                                  }
                                },
                                icon: Icon(Icons.add_box))),
                      )),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: control.pincodesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(control.pincodesList[index]),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            control.removePincode(control.pincodesList[index]);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
