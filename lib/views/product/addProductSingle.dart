import 'package:crm_app/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProductSingleScreen extends StatefulWidget {
  const AddProductSingleScreen({Key? key}) : super(key: key);

  @override
  State<AddProductSingleScreen> createState() => _AddProductSingleScreenState();
}

class _AddProductSingleScreenState extends State<AddProductSingleScreen> {
  TextEditingController _pName = TextEditingController();
  TextEditingController _pColor = TextEditingController();
  TextEditingController _pColorPrice = TextEditingController();
  TextEditingController _pSize = TextEditingController();
  TextEditingController _pStock = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Single Product")),
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
                        controller: _pName,
                        decoration: InputDecoration(
                          hintText: 'Enter the product name',
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
                        controller: _pColor,
                        decoration: InputDecoration(
                          hintText: 'Enter the product colors',
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
                        controller: _pColorPrice,
                        decoration: InputDecoration(
                          hintText: 'Enter the color prices',
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
                        controller: _pSize,
                        
                        decoration: InputDecoration(
                          hintText: 'Enter the product sizes.',
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

                    //------
                    Container(
                      width: 325,
                      child: TextField(
                        controller: _pStock,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter the product stock',
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
                            'Add Single Product',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                        ),
                        onTap: () {
                          ProductService.addSingleProduct(
                              _pColor.text,
                              _pColorPrice.text,
                              _pName.text,
                              _pSize.text,
                              _pStock.text);
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
