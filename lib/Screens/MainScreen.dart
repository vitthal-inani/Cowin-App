import 'package:cowinbooking/NetworkCalls.dart';
import 'package:cowinbooking/Screens/PinCodeScreen.dart';
import 'package:cowinbooking/Screens/DistrictSearch.dart';
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
  List<bool> selected = List.filled(4, false);
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
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            height: _size.height * 0.25,
                            width: _size.width * 0.6,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Search by District or PinCode?",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => districtSearch());
                                      },
                                      child: Text("District")),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => codeSearch());
                                      },
                                      child: Text("Pin Code")),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
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

                  return Container(
                    height: _size.height * 0.5,
                    width: _size.width * 0.8,
                    alignment: Alignment.center,
                    child: ListView.builder(
                        itemCount: bens.length,
                        itemBuilder: (context, index) {
                          // print(bens[index]);
                          return Container(
                            // decoration: BoxDecoration(border: Border.all(width: 2,color:Colors.lightBlueAccent)),
                            margin: EdgeInsets.symmetric(vertical: _size.height*0.01),
                            child: CheckboxListTile(
                              selected: selected[index],
                              value: selected[index],
                              onChanged: (check) {
                                setState(() {
                                  selected[index] = check!;
                                });
                                if (selected[index] == false) {
                                  control.removeBen(
                                      bens[index]['beneficiary_reference_id']);
                                }
                                if (selected[index] == true) {
                                  control.addBen(
                                      bens[index]['beneficiary_reference_id']);
                                }
                                // print(control.bens);
                              },
                              title: Text(bens[index]['name']),
                              subtitle: Text(bens[index]['vaccination_status']),
                            ),
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
