import 'package:crm_app/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductBoxScreen extends StatefulWidget {
  const EditProductBoxScreen(
      {Key? key, required this.productName, required this.productType})
      : super(key: key);
  final productName, productType;
  @override
  State<EditProductBoxScreen> createState() => _EditProductBoxScreenState();
}

class _EditProductBoxScreenState extends State<EditProductBoxScreen> {
  TextEditingController _boxSizePrice = TextEditingController();
  TextEditingController _boxStock = TextEditingController();
  TextEditingController _lidSizePrice = TextEditingController();
  TextEditingController _lidStock = TextEditingController();
  TextEditingController _productName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Box Product')),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: FutureBuilder<dynamic>(
                future: ProductService.getProductDetail(
                    widget.productType, widget.productName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _boxSizePrice.text = snapshot.data[0]['boxSize'].toString();
                    _boxStock.text = snapshot.data[0]['boxStock'].toString();
                    _lidSizePrice.text = snapshot.data[0]['lidSize'].toString();
                    _lidStock.text = snapshot.data[0]['lidStock'].toString();
                    _productName.text =
                        snapshot.data[0]['productName'].toString();

                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 325,
                            child: TextField(
                              enabled: false,
                              controller: _productName,
                              decoration: const InputDecoration(
                                hintText: 'Enter the product name',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Enter the product name',
                            style: TextStyle(color: Colors.white54),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          //------
                          Container(
                            width: 325,
                            child: TextField(
                              controller: _boxSizePrice,
                              decoration: const InputDecoration(
                                hintText: 'Enter the box sizes and Prices',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Entry type(box size and price): size1:unit_price1;price11;price12,size2:unit_price2;price21;price22,size3:unit_price3;price31;price32 \n example:40x50:0.52;0.54;0.56,45x50:0.54;0.54;0.56,50x50:0.56;0.54;0.56 \n use dots in decimal notation!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white54),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          //------
                          Container(
                            width: 325,
                            child: TextField(
                              controller: _lidSizePrice,
                              decoration: const InputDecoration(
                                hintText: 'Enter the lid sizes and Prices',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Entry type(lid size and price): size1:unit_price1;price11;price12,size2:unit_price2;price21;price22,size3:unit_price3;price31;price32 \n example:40x50:0.52;0.54;0.56,45x50:0.54;0.54;0.56,50x50:0.56;0.54;0.56 \n use dots in decimal notation!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white54),
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          //------
                          Container(
                            width: 325,
                            child: TextField(
                              controller: _lidStock,
                              decoration: const InputDecoration(
                                hintText: 'Enter the lid stock',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Enter the lid stock',
                            style: TextStyle(color: Colors.white54),
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          //------

                          //-------------

                          Container(
                            width: 325,
                            child: TextField(
                              controller: _boxStock,
                              decoration: const InputDecoration(
                                hintText: 'Enter the box stock',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Enter the box stock',
                            style: TextStyle(color: Colors.white54),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                              child: Text('Update Box Product'),
                              onPressed: () {
                                ProductService.updateBoxProduct(
                                    _productName.text,
                                    _lidStock.text,
                                    _boxStock.text,
                                    _boxSizePrice.text,
                                    _lidSizePrice.text);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Updated!'),
                                      content:
                                          Text("Product has been updated."),
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
                                  },
                                );
                              })
                        ]);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
