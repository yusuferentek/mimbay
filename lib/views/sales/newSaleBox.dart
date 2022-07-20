import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/views/sales/boxProductPrice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewSaleBoxScreen extends StatefulWidget {
  const NewSaleBoxScreen({Key? key}) : super(key: key);

  @override
  State<NewSaleBoxScreen> createState() => _NewSaleBoxScreenState();
}

class _NewSaleBoxScreenState extends State<NewSaleBoxScreen> {
  TextEditingController _boxAmountController = TextEditingController();
  TextEditingController _lidAmountController = TextEditingController();
  TextEditingController _deliveryController = TextEditingController();
  TextEditingController _boxPrintController = TextEditingController();
  TextEditingController _lidPrintController = TextEditingController();
  var _selectedCustomer,
      _selectedBox,
      _selectedBoxAmount,
      _deliveryPrice,
      _selectedBoxSize,
      _selectedLidAmount,
      _boxPrintPrice,
      _lidPrintPrice,
      _selectedLidSize;
  bool? _selectionsDeliv = false;
  bool? _selectionsBoxPrint = false;
  bool? _selectionsLidPrint = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Box Sale')),
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
                        .collection('customers')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> data = [];
                        for (int i = 0; i < snapshot.data.docs.length; i++) {
                          data.add(snapshot.data.docs[i]['companyName']);
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
                            hint: const Text('Choose Customer Company',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
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
                              .doc('boxProducts')
                              .collection('boxes')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<String> data = [];
                              for (int i = 0;
                                  i < snapshot.data.docs.length;
                                  i++) {
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
                                      _selectedBox = selected;
                                      setState(() {});
                                    });
                                  },
                                  value: _selectedBox,
                                  isExpanded: true,
                                  hint: const Text('Choose Box Product',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
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
                _selectedBox != null
                    ? Center(
                        child: Column(
                          children: [
                            Container(
                              width: 300,
                              child: FutureBuilder<dynamic>(
                                  future: SaleService.getBoxStock(_selectedBox),
                                  builder: (context, snaphots) {
                                    if (snaphots.hasData) {
                                      return Text(
                                        "${snaphots.data}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
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
                _selectedBox != null
                    ? Column(
                        children: [
                          Center(
                            child: FutureBuilder<String>(
                              future: SaleService.getBoxSizePrice(_selectedBox),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<String> data = [];
                                  String sizes = snapshot.data.toString();
                                  data = sizes.split(',');
                                  /**for (int i = 0;
                                      i < snapshot.data.docs.length;
                                      i++) {
                                    data.add(snapshot.data.docs[i]['size']);
                                  }**/

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
                                          _selectedBoxSize = selected;
                                          setState(() {});
                                        });
                                      },
                                      value: _selectedBoxSize,
                                      isExpanded: true,
                                      hint: const Text(
                                          'Choose Box Size and Price',
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
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Container(),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                _selectedBox != null
                    ? Column(
                        children: [
                          Center(
                            child: FutureBuilder<String>(
                              future: SaleService.getLidSizePrice(_selectedBox),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<String> data = [];
                                  String sizes = snapshot.data.toString();
                                  data = sizes.split(',');
                                  /**for (int i = 0;
                                      i < snapshot.data.docs.length;
                                      i++) {
                                    data.add(snapshot.data.docs[i]['size']);
                                  }**/

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
                                          setState(() {
                                            _selectedLidSize = selected;
                                          });
                                        });
                                      },
                                      value: _selectedLidSize,
                                      isExpanded: true,
                                      hint: const Text(
                                          'Choose Lid Size and Price',
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
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Container(),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                _selectedBox != null
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: _boxAmountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Enter the box amount.'),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBoxAmount = value;
                                  });
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
                _selectedBox != null
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: _lidAmountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Enter the lid amount.'),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedLidAmount = value;
                                  });
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
                _selectedBox != null
                    ? Column(
                        children: [
                          _selectionsBoxPrint == true
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          value: _selectionsBoxPrint,
                                          onChanged: (index) {
                                            setState(() {
                                              _selectionsBoxPrint = index;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 225,
                                          child: TextField(
                                            controller: _boxPrintController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText:
                                                    'Enter the Box Print price.'),
                                            onChanged: (value) {
                                              _boxPrintPrice = value;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Box is Printed?:  '),
                                        Checkbox(
                                            value: _selectionsBoxPrint,
                                            onChanged: (inds) {
                                              setState(() {
                                                _selectionsBoxPrint = inds;
                                              });
                                            }),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                          _selectionsLidPrint == true
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          value: _selectionsLidPrint,
                                          onChanged: (index) {
                                            setState(() {
                                              _selectionsLidPrint = index;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 225,
                                          child: TextField(
                                            controller: _lidPrintController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Enter the Lid Print price.'),
                                            onChanged: (value) {
                                              _lidPrintPrice = value;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Lid is Printed?:  '),
                                        Checkbox(
                                            value: _selectionsLidPrint,
                                            onChanged: (inds) {
                                              setState(() {
                                                _selectionsLidPrint = inds;
                                              });
                                            }),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                          _selectionsDeliv == true
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                        ],
                      )
                    : Container(),
                _selectedBox != null
                    ? Column(
                        children: [
                          Center(
                            child: ElevatedButton(
                              child: Text('Continue Sale'),
                              onPressed: () {
                                if (_selectionsBoxPrint == false) {
                                  _boxPrintController.text = "0";
                                }
                                if (_selectionsLidPrint == false) {
                                  _lidPrintController.text = "0";
                                }
                                if (_selectionsDeliv == false) {
                                  _deliveryController.text = "0";
                                }
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BoxProductPriceScreen(
                                          boxAmount: _selectedBoxAmount,
                                          boxIsPrinted: _selectionsBoxPrint,
                                          customerName: _selectedCustomer,
                                          lidAmount: _selectedLidAmount,
                                          lidIsPrinted: _selectionsLidPrint,
                                          productName: _selectedBox,
                                          boxSize: _selectedBoxSize,
                                          lidSize: _selectedLidSize,
                                          boxPrintPrice:
                                              _boxPrintController.text,
                                          lidPrintPrice:
                                              _lidPrintController.text,
                                          deliveryIsSelected: _selectionsDeliv,
                                          deliveryPrice:
                                              _deliveryController.text,
                                        )));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          )
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
