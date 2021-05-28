import 'package:cowinbooking/NetworkCalls.dart';
import 'package:flutter/material.dart';

class districtSearch extends StatefulWidget {
  @override
  _districtSearchState createState() => _districtSearchState();
}

class _districtSearchState extends State<districtSearch> {
  String? _selectedState;
  int _stateid = 1;
  String? _selectedDistrict;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Choose your location")),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _size.width * 0.05, vertical: _size.height * 0.05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                    future: NetworkCalls.getStates(),
                    builder: (context, AsyncSnapshot<Map> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data != null) {
                          // print(snapshot.data);
                          List states = [];
                          for (var i in snapshot.data!['states']) {
                            states.add(i['state_name']);
                          }

                          return SizedBox(
                            width: _size.width * 0.35,
                            child: DropdownButton(
                              hint: Text("State ..."),
                              isExpanded: true,
                              value: _selectedState,
                              items: states
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedState = val.toString();
                                  _stateid = states.indexOf(_selectedState);
                                });
                              },
                            ),
                          );
                        }
                      }
                      return CircularProgressIndicator();
                    }),
                (_selectedState != null)
                    ? FutureBuilder(
                        future: NetworkCalls.getDistrict(_stateid),
                        builder: (context, AsyncSnapshot<Map> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data != null) {
                              print(snapshot.data);
                              List _districts = [];
                              for (var i in snapshot.data!['districts']) {
                                _districts.add(i['district_name']);
                              }

                              return DropdownButton(
                                hint: Text("District ..."),
                                value: _selectedDistrict,
                                items: _districts
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedDistrict = val.toString();
                                  });
                                },
                              );
                            }
                          }
                          return CircularProgressIndicator();
                        })
                    : Text("Select State"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
