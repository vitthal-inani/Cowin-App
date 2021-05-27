import 'package:cowinbooking/NetworkCalls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cowinbooking/Metadata.dart' as Meta;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool activate = false;
  Meta.MetaData control = Get.put(Meta.MetaData());

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
      appBar: AppBar(
        title: Text("Beneficiaries"),
        bottom: PreferredSize(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              color: Colors.blueAccent,
              child: Center(
                  child: Text(
                "Select the Beneficiaries",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ))),
          preferredSize: Size.fromHeight(_size.height * 0.04),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, bottom: 15),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.only(
                        left: 15, right: 18, top: 10, bottom: 10)),
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward,
                  size: 22,
                ),
                label: Text(
                  "Submit",
                  style: TextStyle(fontSize: 21),
                ),
              ),
            ),
          ),
          Center(
            child: FutureBuilder(
              future: NetworkCalls.getBenefeciaries(),
              builder: (context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null)
                    return Center(
                      child: Text("No Beneficiaries"),
                    );
                  List bens = snapshot.data!['beneficiaries'];
                  return SizedBox(
                    height: _size.height * 0.2,
                    width: _size.width * 0.8,
                    child: ListView.builder(
                        itemCount: bens.length,
                        itemBuilder: (context, index) {
                          // print(bens[index]);
                          return CheckboxListTile(
                            selected: activate,
                            value: activate,
                            onChanged: (check) {
                              setState(() {
                                activate = check!;
                              });
                              if (activate == false) {
                                control.removeBen(
                                    bens[index]['beneficiary_reference_id']);
                              }
                              if (activate == true) {
                                control.addBen(
                                    bens[index]['beneficiary_reference_id']);
                              }
                              // print(control.bens);
                            },
                            title: Text(bens[index]['name']),
                            subtitle: Text(bens[index]['vaccination_status']),
                          );
                        }),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}