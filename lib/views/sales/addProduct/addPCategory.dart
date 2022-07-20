import 'package:crm_app/views/sales/addProduct/addPBox.dart';
import 'package:crm_app/views/sales/addProduct/addPSet.dart';
import 'package:crm_app/views/sales/addProduct/addPSingle.dart';
import 'package:flutter/material.dart';

class AddPCategoryScreen extends StatefulWidget {
  const AddPCategoryScreen({Key? key, required this.saleID}) : super(key: key);
  final saleID;
  @override
  State<AddPCategoryScreen> createState() => _AddPCategoryScreenState();
}

class _AddPCategoryScreenState extends State<AddPCategoryScreen> {
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AddPSingleScreen(saleID: widget.saleID)));
              } else if (_selectedCategory == 'set') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AddPSetScreen(saleID: widget.saleID)));
              } else if (_selectedCategory == 'box') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddPBoxScreen(
                          saleID: widget.saleID,
                        )));
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
