import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_app/views/sales/addProduct/addPSetPrice.dart';
import 'package:crm_app/widgets/selectContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/saleService.dart';
import '../setSalePrice.dart';

class AddPSetScreen extends StatefulWidget {
  const AddPSetScreen({Key? key, required this.saleID}) : super(key: key);
  final saleID;
  @override
  State<AddPSetScreen> createState() => _AddPSetScreenState();
}

class _AddPSetScreenState extends State<AddPSetScreen> {
  var _selectedNapkinColor;

  var _selectedProduct;
  var _selectedNapkinColorPrice;
  var _selectedWetWipesColor;
  var _selectedWetwipesColorPrice;
  var _selectedWetwipesColorPriceText;
  var _piece;
  var _deliveryPrice;
  var _selectedNapkinColorPriceText;

  final List<String> _selectedContents = [];
  TextEditingController _napkinColorPriceController = TextEditingController();
  TextEditingController _wetwipesColorPriceController = TextEditingController();
  TextEditingController _setPieceController = TextEditingController();
  TextEditingController _deliveryController = TextEditingController();
  List<String> _selectedItems = [];

  void _showMultiSelect(contents) async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SelectContentWidget(
          contents: contents,
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('New Set Sale')),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: StreamBuilder<dynamic>(
                            stream: FirebaseFirestore.instance
                                .collection('categories')
                                .doc('setProducts')
                                .collection('sets')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<String> data = [];
                                for (int i = 0;
                                    i < snapshot.data.docs.length;
                                    i++) {
                                  data.add(
                                      snapshot.data.docs[i]['productName']);
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
                                    hint: const Text('Choose Set Product',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                        _selectedProduct != null
                            ? Center(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: FutureBuilder<dynamic>(
                                          future: SaleService.getSetStock(
                                              _selectedProduct),
                                          builder: (context, snaphots) {
                                            if (snaphots.hasData) {
                                              return Text(
                                                "Stock: ${snaphots.data}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                        _selectedProduct != null
                            ? Center(
                                child: Column(
                                  children: [
                                    FutureBuilder<dynamic>(
                                      future: SaleService.getSetContent(
                                          _selectedProduct),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<String> contents = [];

                                          for (int i = 0;
                                              i < snapshot.data.length;
                                              i++) {
                                            contents.add(snapshot.data[i]);
                                          }
                                          return ElevatedButton(
                                              child: Text('Select Content'),
                                              onPressed: () {
                                                _showMultiSelect(contents);
                                              });
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                        _selectedItems.isNotEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    FutureBuilder<dynamic>(
                                      future: SaleService.getSetNapkinColor(
                                          _selectedProduct),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<String> napkinColors = [];
                                          for (int i = 0;
                                              i < snapshot.data.length;
                                              i++) {
                                            napkinColors.add(snapshot.data[i]);
                                          }
                                          return Container(
                                            width: 300,
                                            child: DropdownButton(
                                              items: napkinColors
                                                  .map((x) => DropdownMenuItem(
                                                        child: Text(x),
                                                        value: x,
                                                      ))
                                                  .toList(),
                                              onChanged: (selected) {
                                                setState(() {
                                                  _selectedNapkinColor =
                                                      selected;
                                                });
                                              },
                                              value: _selectedNapkinColor,
                                              isExpanded: true,
                                              hint: Text(
                                                  'Choose ${_selectedProduct} Napkin Color',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12)),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                        _selectedNapkinColor != null &&
                                _selectedNapkinColor != 'none'
                            ? Center(
                                child: Column(
                                  children: [
                                    FutureBuilder<dynamic>(
                                      future:
                                          SaleService.getSetNapkinColorPrice(
                                              _selectedProduct),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<String> colors = [];
                                          for (int i = 0;
                                              i < snapshot.data.length;
                                              i++) {
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
                                                  _selectedNapkinColorPriceText =
                                                      selected;
                                                });
                                              },
                                              value:
                                                  _selectedNapkinColorPriceText,
                                              isExpanded: true,
                                              hint: Text(
                                                  'Choose ${_selectedProduct} Napkin Color Price',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12)),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                        _selectedNapkinColorPrice == 'other'
                            ? Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: TextField(
                                        controller: _napkinColorPriceController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Enter the manual color price.'),
                                        onChanged: (value) {
                                          _selectedNapkinColorPriceText = value;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                        _selectedNapkinColor != null
                            ? Center(
                                child: Column(
                                  children: [
                                    FutureBuilder<dynamic>(
                                      future: SaleService.getSetWetWipesColor(
                                          _selectedProduct),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<String> wetWipesColors = [];
                                          for (int i = 0;
                                              i < snapshot.data.length;
                                              i++) {
                                            wetWipesColors
                                                .add(snapshot.data[i]);
                                          }
                                          return Container(
                                            width: 300,
                                            child: DropdownButton(
                                              items: wetWipesColors
                                                  .map((x) => DropdownMenuItem(
                                                        child: Text(x),
                                                        value: x,
                                                      ))
                                                  .toList(),
                                              onChanged: (selected) {
                                                setState(() {
                                                  _selectedWetWipesColor =
                                                      selected;
                                                });
                                              },
                                              value: _selectedWetWipesColor,
                                              isExpanded: true,
                                              hint: Text(
                                                  'Choose ${_selectedProduct} Wetwipes Color',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12)),
                                            ),
                                          );
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                        _selectedWetWipesColor != null &&
                                _selectedWetWipesColor != 'none'
                            ? Center(
                                child: Column(
                                  children: [
                                    FutureBuilder<dynamic>(
                                      future:
                                          SaleService.getSetWetwipesColorPrice(
                                              _selectedProduct),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<String> wetwipesColorPrices = [];
                                          for (int i = 0;
                                              i < snapshot.data.length;
                                              i++) {
                                            wetwipesColorPrices
                                                .add(snapshot.data[i]);
                                          }
                                          return Container(
                                            width: 300,
                                            child: DropdownButton(
                                              items: wetwipesColorPrices
                                                  .map((x) => DropdownMenuItem(
                                                        child: Text(x),
                                                        value: x,
                                                      ))
                                                  .toList(),
                                              onChanged: (selected) {
                                                setState(() {
                                                  _selectedWetwipesColorPriceText =
                                                      selected;
                                                });
                                              },
                                              value:
                                                  _selectedWetwipesColorPriceText,
                                              isExpanded: true,
                                              hint: Text(
                                                  'Choose $_selectedProduct Wetwipes Color Price',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12)),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                        _selectedWetwipesColorPrice == 'other'
                            ? Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: TextField(
                                        controller:
                                            _wetwipesColorPriceController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Enter the manual color price.'),
                                        onChanged: (value) {
                                          _selectedWetwipesColorPriceText =
                                              value;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                        _selectedWetWipesColor != null
                            ? Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: TextField(
                                        controller: _setPieceController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            hintText: 'Enter the piece.'),
                                        onChanged: (value) {
                                          _piece = value;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                        Center(
                          child: ElevatedButton(
                            child: Text('Continue Price Information'),
                            onPressed: () {
                              var wetwipesPrice, napkinCPrice;
                              if (_selectedWetwipesColorPrice == 'other') {
                                _selectedWetwipesColorPrice =
                                    _selectedWetwipesColorPriceText;
                              }
                              if (_selectedNapkinColorPrice == 'other') {
                                _selectedNapkinColorPrice =
                                    _selectedNapkinColorPriceText;
                              }
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddPSetScreenPrice(
                                      productName: _selectedProduct,
                                      selectedContent: _selectedItems,
                                      napkinColor: _selectedNapkinColor,
                                      napkinColorPrice:
                                          _selectedNapkinColorPriceText,
                                      wetwipesColor: _selectedWetWipesColor,
                                      wetwipesColorPrice:
                                          _selectedWetwipesColorPriceText,
                                      setPiece: _piece,
                                      saleID: widget.saleID)));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ]),
                ))));
  }
}
