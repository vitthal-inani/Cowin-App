import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey _form = GlobalKey<FormState>();

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
              child: TextFormField(
                decoration: InputDecoration(
                    helperText: "Phone Number",
                    prefixIcon: Text("+91"),
                    suffix: IconButton(
                      icon: Icon(Icons.arrow_forward_sharp),
                      onPressed: () {},
                    )),
              ),
            ),
          ),
          SizedBox(
            width: _size.width * 0.8,
            child: Form(
              child: TextFormField(
                decoration: InputDecoration(
                  helperText: "Phone Number",
                  prefixIcon: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 5),
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                      ),
                      child: Text("+91")),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
