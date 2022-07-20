import 'dart:ffi';

import 'package:crm_app/views/sales/createSaleSingle.dart';
import 'package:crm_app/views/sales/newSaleBox.dart';
import 'package:crm_app/views/sales/newSaleSet.dart';
import 'package:crm_app/views/sales/newSaleSingle.dart';
import 'package:flutter/material.dart';

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({Key? key}) : super(key: key);

  @override
  _ChooseCategoryScreenState createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  List<String> _category = <String>["set", "box", "single"];
  var _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Category')),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
          ),
          Text(
            'Please Choose a Category',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: 300,
              child: DropdownButton(
                items: _category
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (selectCat) {
                  setState(() {
                    _selectedCategory = selectCat;
                  });
                },
                value: _selectedCategory,
                isExpanded: true,
                hint: Text('Choose Category',
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            child: Container(
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  color: Colors.blueGrey),
              child: Center(
                  child: Text(
                'Continue',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
            ),
            onTap: () {
              if (_selectedCategory == 'single') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NewSaleSingleScreen()));
              } else if (_selectedCategory == 'set') {
                 Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>NewSaleSetScreen()));
              } else if (_selectedCategory == 'box') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>NewSaleBoxScreen()));
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text("Please Choose a Category"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              //setState(() {});
                            },
                          ),
                        ],
                      );
                    });
              }
            },
          )
        ],
      ),
    );
  }
}
