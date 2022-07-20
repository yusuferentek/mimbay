import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/productService.dart';

class AddProductSetScreen extends StatefulWidget {
  const AddProductSetScreen({Key? key}) : super(key: key);

  @override
  State<AddProductSetScreen> createState() => _AddProductSetScreenState();
}

class _AddProductSetScreenState extends State<AddProductSetScreen> {
  TextEditingController _setName = TextEditingController();
  TextEditingController _napkinColor = TextEditingController();
  TextEditingController _napkinColorPrice = TextEditingController();
  TextEditingController _wetWipesColor = TextEditingController();
  TextEditingController _wetWipesColorPrice = TextEditingController();
  TextEditingController _setContent = TextEditingController();
  TextEditingController _setStock = TextEditingController();
  TextEditingController _unitPrice = TextEditingController();
  
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
                        controller: _setName,
                        decoration: InputDecoration(
                          hintText: 'Enter the set name',
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
                        controller: _napkinColor,
                        decoration: InputDecoration(
                          hintText: 'Enter the napkin colors',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Entry type: none,color1,color2,color3 \n example:none,1,2,3,4',
                      style: TextStyle(color: Colors.white54),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    //------
                    Container(
                      width: 325,
                      child: TextField(
                        controller: _napkinColorPrice,
                        decoration: InputDecoration(
                          hintText: 'Enter the napkin color pces',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Entry type: price1,price2,price3,other \n example:50,75,100,125,other',
                      style: TextStyle(color: Colors.white54),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    //------

                    Container(
                      width: 325,
                      child: TextField(
                        controller: _wetWipesColor,
                        decoration: InputDecoration(
                          hintText: 'Enter the Wet Wipes colors',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Entry type: none,color1,color2,color3 \n example:none,1,2,3,4',
                      style: TextStyle(color: Colors.white54),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //-------------

                    Container(
                      width: 325,
                      child: TextField(
                        controller: _wetWipesColorPrice,
                        decoration: InputDecoration(
                          hintText: 'Enter the wet wipes color pieces',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Entry type: price1,price2,price3,other \n example:50,75,100,125,other',
                      style: TextStyle(color: Colors.white54),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    //------

                    Container(
                      width: 325,
                      child: TextField(
                        controller: _setContent,
                        decoration: InputDecoration(
                          hintText: 'Enter the set content.',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Entry type: content1,content2,content3',
                      style: TextStyle(color: Colors.white54),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    //------

                    Container(
                      width: 325,
                      child: TextField(
                        controller: _unitPrice,
                        decoration: InputDecoration(
                          hintText: 'Enter the unit price.',
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    //------

                    Container(
                      width: 325,
                      child: TextField(
                        controller: _setStock,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter the set stock',
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
                            'Add Set Product',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                        ),
                        onTap: () {
                          ProductService.addSetProduct(
                              _napkinColor.text,
                              _napkinColorPrice.text,
                              _unitPrice.text,
                              _setName.text,
                              _setContent.text,
                              _setStock.text,
                              _wetWipesColor.text,
                              _wetWipesColorPrice.text);
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
