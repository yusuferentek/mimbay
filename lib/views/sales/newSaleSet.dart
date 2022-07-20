import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/views/sales/setSalePrice.dart';
import 'package:crm_app/widgets/selectContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class NewSaleSetScreen extends StatefulWidget {
  const NewSaleSetScreen({Key? key}) : super(key: key);

  @override
  State<NewSaleSetScreen> createState() => _NewSaleSetScreenState();
}

class _NewSaleSetScreenState extends State<NewSaleSetScreen> {
  var _selectedNapkinColor;
  var _selectedCustomer;
  var _selectedProduct;
  var _selectedNapkinColorPrice;
  var _selectedWetWipesColor;
  var _selectedWetwipesColorPrice;
  var _selectedWetwipesColorPriceText;
  var _piece;
  var _deliveryPrice;
  var _selectedNapkinColorPriceText;
  bool? _selectionsDeliv = false;
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
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: StreamBuilder<dynamic>(
                            stream: FirebaseFirestore.instance
                                .collection('customers')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<String> data = [];
                                for (int i = 0;
                                    i < snapshot.data.docs.length;
                                    i++) {
                                  data.add(
                                      snapshot.data.docs[i]['companyName']);
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
                                        _selectedCustomer = selected;
                                      });
                                      setState(() {});
                                    },
                                    value: _selectedCustomer,
                                    isExpanded: true,
                                    hint: Text('Choose Customer Company',
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
                        const SizedBox(
                          height: 30,
                        ),
                        _selectedCustomer != null
                            ? Center(
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
                                        data.add(snapshot.data.docs[i]
                                            ['productName']);
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
                                          hint: const Text(
                                              'Choose Single Product',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
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
                                              child: Text('Select Contents'),
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
                                                  _selectedNapkinColorPrice =
                                                      selected;
                                                });
                                              },
                                              value: _selectedNapkinColorPrice,
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
                                                  _selectedWetwipesColorPrice =
                                                      selected;
                                                });
                                              },
                                              value:
                                                  _selectedWetwipesColorPrice,
                                              isExpanded: true,
                                              hint: Text(
                                                  'Choose $_selectedProduct Wetwipes Color Price',
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
                        _selectionsDeliv == true
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: _selectionsDeliv,
                                        onChanged: (index) {
                                          setState(() {
                                            _selectionsDeliv = index;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 225,
                                        child: TextField(
                                          controller: _deliveryController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Enter the delivery price.'),
                                          onChanged: (value) {
                                            _deliveryPrice = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('To Enter a Delivery Fee:  '),
                                      Checkbox(
                                          value: _selectionsDeliv,
                                          onChanged: (inds) {
                                            setState(() {
                                              _selectionsDeliv = inds;
                                            });
                                          }),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
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
                                  builder: (context) => SetSalePriceScreen(
                                        customerName: _selectedCustomer,
                                        deliveryPrice: _deliveryPrice,
                                        napkinColor: _selectedNapkinColor,
                                        napkinColorPrice:
                                            _selectedNapkinColorPrice,
                                        productName: _selectedProduct,
                                        selectedContent: _selectedItems,
                                        setPiece: _piece,
                                        wetwipesColor: _selectedWetWipesColor,
                                        wetwipesColorPrice:
                                            _selectedWetwipesColorPrice,
                                      )));
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
