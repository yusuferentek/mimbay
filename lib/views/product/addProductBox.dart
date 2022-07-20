import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/productService.dart';

class AddProductBoxScreen extends StatefulWidget {
  const AddProductBoxScreen({Key? key}) : super(key: key);

  @override
  State<AddProductBoxScreen> createState() => _AddProductBoxScreenState();
}

class _AddProductBoxScreenState extends State<AddProductBoxScreen> {
  TextEditingController _boxName = TextEditingController();
  TextEditingController _boxStock = TextEditingController();
  TextEditingController _lidStock = TextEditingController();
  TextEditingController _lidSizePrice = TextEditingController();
  TextEditingController _boxSizePrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Set Product")),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //-----
                    Container(
                      width: 325,
                      child: TextField(
                        controller: _boxName,
                        decoration: InputDecoration(
                          hintText: 'Enter the box name',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    Container(
                      width: 325,
                      child: TextField(
                        controller: _boxSizePrice,
                        decoration: InputDecoration(
                          hintText: 'Enter the box sizes and prices.',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Entry type: size1:unit_price1;price11;price12,size2:unit_price2;price21;price22,size3:unit_price3;price31;price32 \n example:40x50:0.52;0.54;0.56,45x50:0.54;0.54;0.56,50x50:0.56;0.54;0.56 \n use dots in decimal notation!',
                      style: TextStyle(color: Colors.white54),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    Container(
                      width: 325,
                      child: TextField(
                        controller: _lidSizePrice,
                        decoration: InputDecoration(
                          hintText: 'Enter the lid sizes and prices.',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Entry type: size1:unit_price1;price11;price12,size2:unit_price2;price21;price22,size3:unit_price3;price31;price32 \n example:40x50:0.52;0.54;0.56,45x50:0.54;0.54;0.56,50x50:0.56;0.54;0.56 \n use dots in decimal notation!',
                      style: TextStyle(color: Colors.white54),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    Container(
                      width: 325,
                      child: TextField(
                        controller: _lidStock,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter the set lid stock',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    //------

                    Container(
                      width: 325,
                      child: TextField(
                        controller: _boxStock,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter the set box stock',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    //------

                    Center(
                      child: InkWell(
                        child: Container(
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                              color: Colors.blueGrey),
                          child: Center(
                              child: Text(
                            'Add Box Product',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                        ),
                        onTap: () {
                          ProductService.addBoxProduct(
                              _boxName.text,
                              _lidStock.text,
                              _boxStock.text,
                              _boxSizePrice.text,
                              _lidSizePrice.text);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Added!'),
                                  content: Text("Product has been added."),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
