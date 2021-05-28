import 'package:flutter/material.dart';

class codeSearch extends StatefulWidget {
  @override
  _codeSearchState createState() => _codeSearchState();
}

class _codeSearchState extends State<codeSearch> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

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
                        decoration: InputDecoration(hintText: "Enter Pincode"),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
