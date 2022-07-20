import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_app/views/sales/addProduct/addPsinglePrice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/saleService.dart';

class AddPSingleScreen extends StatefulWidget {
  const AddPSingleScreen({Key? key, required this.saleID}) : super(key: key);
  final saleID;
  @override
  State<AddPSingleScreen> createState() => _AddPSingleScreenState();
}

class _AddPSingleScreenState extends State<AddPSingleScreen> {
  var _selectedProduct;
  var _selectedColor;
  var _selectedColorPrice;
  var _selectedSize;
  var _lastColorPrice;
  String pieceText = "";
  String colorPriceText = "";
  TextEditingController _pieceController = new TextEditingController();
  TextEditingController _colorPriceController = new TextEditingController();
  TextEditingController _deliveryController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double total = 0;
    return Scaffold(
      appBar: AppBar(title: Text('Add Single Product')),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: StreamBuilder<dynamic>(
                  stream: FirebaseFirestore.instance
                      .collection('categories')
                      .doc('singleProducts')
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<String> data = [];
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        data.add(snapshot.data.docs[i]['productName']);
                      }

                      return Container(
                        width: 300,
                        child: DropdownButton(
                          items: data
                              .map((x) => DropdownMenuItem(
                                    child: Text(x),
                                    value: x,
                                  ))
                              .toList(),
                          onChanged: (selected) {
                            setState(() {
                              _selectedProduct = selected;
                              setState(() {});
                            });
                          },
                          value: _selectedProduct,
                          isExpanded: true,
                          hint: const Text('Choose Single Product',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _selectedProduct != null
                  ? Center(
                      child: FutureBuilder<dynamic>(
                        future: SaleService.getSingleSize(_selectedProduct),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<String> sizes = [];
                            for (int i = 0; i < snapshot.data.length; i++) {
                              sizes.add(snapshot.data[i]);
                            }
                            return Container(
                              width: 300,
                              child: DropdownButton(
                                items: sizes
                                    .map((x) => DropdownMenuItem(
                                          child: Text(x),
                                          value: x,
                                        ))
                                    .toList(),
                                onChanged: (selected) {
                                  setState(() {
                                    _selectedSize = selected;
                                  });
                                },
                                value: _selectedSize,
                                isExpanded: true,
                                hint: Text('Choose ${_selectedProduct} Size',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    )
                  : Center(
                      child: Container(
                          width: 300,
                          child: DropdownButton(
                            items: null,
                            onChanged: null,
                            isExpanded: true,
                          ))),
              SizedBox(
                height: 30,
              ),
              _selectedProduct != null && _selectedSize != null
                  ? Center(
                      child: FutureBuilder<dynamic>(
                        future: SaleService.getSingleColor(_selectedProduct),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<String> colors = [];
                            for (int i = 0; i < snapshot.data.length; i++) {
                              colors.add(snapshot.data[i]);
                            }
                            return Container(
                              width: 300,
                              child: DropdownButton(
                                items: colors
                                    .map((x) => DropdownMenuItem(
                                          child: Text(x),
                                          value: x,
                                        ))
                                    .toList(),
                                onChanged: (selected) {
                                  setState(() {
                                    _selectedColor = selected;
                                  });
                                },
                                value: _selectedColor,
                                isExpanded: true,
                                hint: Text('Choose ${_selectedProduct} Color',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    )
                  : Center(
                      child: Container(
                          width: 300,
                          child: DropdownButton(
                            items: null,
                            onChanged: null,
                            isExpanded: true,
                          ))),
              SizedBox(
                height: 30,
              ),
              _selectedProduct != null &&
                      _selectedColor != null &&
                      _selectedSize != null &&
                      _selectedColor != 'none'
                  ? Center(
                      child: FutureBuilder<dynamic>(
                        future:
                            SaleService.getSingleColorPrice(_selectedProduct),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<String> colors = [];
                            for (int i = 0; i < snapshot.data.length; i++) {
                              colors.add(snapshot.data[i]);
                            }
                            return Container(
                              width: 300,
                              child: DropdownButton(
                                items: colors
                                    .map((x) => DropdownMenuItem(
                                          child: Text(x),
                                          value: x,
                                        ))
                                    .toList(),
                                onChanged: (selected) {
                                  setState(() {
                                    _selectedColorPrice = selected;
                                  });
                                },
                                value: _selectedColorPrice,
                                isExpanded: true,
                                hint: Text(
                                    'Choose ${_selectedProduct} Color Price',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    )
                  : Center(
                      child: Container(
                          width: 300,
                          child: DropdownButton(
                            items: null,
                            onChanged: null,
                            isExpanded: true,
                          ))),
              SizedBox(
                height: 30,
              ),
              _selectedColorPrice == 'other'
                  ? Center(
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            child: TextField(
                              controller: _colorPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Enter the manual color price.'),
                              onChanged: (value) {
                                if (_colorPriceController.text != "") {
                                  setState(() {
                                    colorPriceText = value.toString();
                                  });
                                } else {
                                  colorPriceText = value.toString();
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    )
                  : Container(),
              _selectedProduct != null &&
                      _selectedColor != null &&
                      _selectedSize != null &&
                      _selectedColor != null
                  ? Center(
                      child: Container(
                        width: 300,
                        child: TextField(
                          controller: _pieceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Enter the number of pieces.'),
                          onChanged: (value) {
                            setState(() {
                              if (value.toString() != "") {
                                pieceText = value;
                              } else {
                                pieceText = value;
                              }
                            });
                            setState(() {});
                          },
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 30,
              ),
              _selectedProduct != null &&
                      _selectedSize != null &&
                      _pieceController.text != ""
                  ? Center(
                      child: FutureBuilder<dynamic>(
                          future: SaleService.getSingleStock(_selectedProduct),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              String size = _selectedSize.toString();
                              size = size.substring(size.indexOf(':') + 1);
                              var unitPrices = size.split(';');
                              String piece = pieceText;
                              int _piece = int.parse(piece);
                              var sP;
                              if (_piece < 10000) {
                                sP = unitPrices[0];
                              } else if (_piece < 20000) {
                                sP = unitPrices[1];
                              } else if (_piece > 20000) {
                                sP = unitPrices[2];
                              } else if (_piece > 50000) {
                                sP = unitPrices[3];
                              }else if(_piece > 100000){
                                sP =unitPrices[4];
                              }

                              var _price = num.tryParse(sP)?.toDouble();

                              int _colorPrice;
                              int _deliveryF;
                              total = _price! * _piece;
                              if (_selectedColor != 'none' &&
                                  _deliveryController.text != "" &&
                                  _selectedColorPrice != 'other') {
                                _colorPrice = int.parse(_selectedColorPrice) *
                                    int.parse(_selectedColor);
                                //_deliveryF = int.parse(deliveryText);
                                total = total + _colorPrice;
                                _lastColorPrice = _colorPrice;
                              } else if (_selectedColor == 'none' &&
                                  _deliveryController.text != "") {
                                //_deliveryF = int.parse(deliveryText);
                                total = total;
                                _lastColorPrice = _selectedColor;
                              } else if (_selectedColor != 'none' &&
                                  _deliveryController.text == "" &&
                                  _selectedColorPrice != 'other') {
                                _colorPrice = int.parse(_selectedColorPrice) *
                                    int.parse(_selectedColor);
                                total = total + _colorPrice;
                                _lastColorPrice = _colorPrice;
                              } else if (_selectedColor != 'none' &&
                                  _deliveryController.text != "" &&
                                  _selectedColorPrice == 'other') {
                                _colorPrice = int.parse(colorPriceText) *
                                    int.parse(_selectedColor);
                                //_deliveryF = int.parse(deliveryText);
                                total = total + _colorPrice;
                                _lastColorPrice = _colorPrice;
                              } else if (_selectedColor != 'none' &&
                                  _deliveryController.text == "" &&
                                  _selectedColorPrice == 'other' &&
                                  _colorPriceController.text != "") {
                                _colorPrice = int.parse(colorPriceText) *
                                    int.parse(_selectedColor);
                                total = total + _colorPrice;
                                _lastColorPrice = _colorPrice;
                              }
                              String stock = snapshot.data;

                              return Text(
                                "Stock: ${stock}",
                                style: const TextStyle(
                                    letterSpacing: 1.5, fontSize: 18),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  child: Container(
                    width: 200,
                    height: 30,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        color: Colors.blueGrey),
                    child: const Center(
                        child: Text(
                      'Continue the Sale',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                  ),
                  onTap: () {
                    if (_selectedColorPrice == 'other') {
                      _selectedColorPrice = null;
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddPSinglePrice(
                            total: total,
                            saleID: widget.saleID,
                            productColor: _selectedColor,
                            productColorPrice:
                                _selectedColorPrice ?? colorPriceText,
                            productName: _selectedProduct,
                            productSize: _selectedSize,
                            piece: pieceText)));
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
