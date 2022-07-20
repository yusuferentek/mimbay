import 'package:flutter/material.dart';

import '../../services/saleService.dart';

class AddRecentBoxScreen extends StatefulWidget {
  const AddRecentBoxScreen({
    Key? key,
    required this.customerName,
    required this.productName,
    required this.saleID,
    required this.boxSize,
    required this.lidSize,
    required this.boxAmount,
    required this.lidAmount,
    required this.boxIsPrinted,
    required this.lidIsPrinted,
    required this.boxPrintPrice,
    required this.lidPrintPrice,
    required this.pID,
    required this.lastPrice,
    required this.proformCount,
    required this.saleDetail,
    required this.products,
  }) : super(key: key);
  final customerName,
      productName,
      saleID,
      boxSize,
      lidSize,
      boxAmount,
      lidAmount,
      boxIsPrinted,
      lidIsPrinted,
      boxPrintPrice,
      lidPrintPrice,
      pID,
      lastPrice,
      proformCount,
      saleDetail,
      products;
  @override
  State<AddRecentBoxScreen> createState() => _AddRecentBoxScreenState();
}

class _AddRecentBoxScreenState extends State<AddRecentBoxScreen> {
  var _selectedBoxSize;
  var _selectedLidSize;
  var lastBoxAmount;
  var lastLidAmount;
  var updatedBoxPrintPrice;
  var updatedLidPrintPrice;
  var updatedPrice;
  TextEditingController _boxAmountCont = TextEditingController();
  TextEditingController _lidAmountCont = TextEditingController();
  TextEditingController _boxPrintPriceCont = TextEditingController();
  TextEditingController _lidPrintPriceCont = TextEditingController();
  TextEditingController _priceCont = TextEditingController();
  void initState() {
    _selectedBoxSize = widget.boxSize;
    _selectedLidSize = widget.lidSize;
    _boxAmountCont.text = widget.boxAmount;
    _lidAmountCont.text = widget.lidAmount;
    _boxPrintPriceCont.text = widget.boxPrintPrice;
    _lidPrintPriceCont.text = widget.lidPrintPrice;
    _priceCont.text = widget.lastPrice;
    lastBoxAmount = widget.boxAmount;
    lastLidAmount = widget.lidAmount;
    updatedBoxPrintPrice = widget.boxPrintPrice;
    updatedLidPrintPrice = widget.lidPrintPrice;
    updatedPrice = widget.lastPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Sale')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Customer Name: ${widget.customerName}',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Product Name: ${widget.productName}',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Box Size: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<dynamic>(
                    future: SaleService.getBoxSize(widget.productName),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> colors = [];
                        for (int i = 0; i < snapshot.data.length; i++) {
                          colors.add(snapshot.data[i]);
                        }
                        return Container(
                          width: 150,
                          child: DropdownButton(
                            items: colors
                                .map((x) => DropdownMenuItem(
                                      child: Text(x),
                                      value: x,
                                    ))
                                .toList(),
                            onChanged: (selected) {
                              setState(() {
                                _selectedBoxSize = selected;
                              });
                            },
                            value: _selectedBoxSize,
                            isExpanded: true,
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Lid Size: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<dynamic>(
                    future: SaleService.getLidSize(widget.productName),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> colors = [];
                        for (int i = 0; i < snapshot.data.length; i++) {
                          colors.add(snapshot.data[i]);
                        }
                        return Container(
                          width: 150,
                          child: DropdownButton(
                            items: colors
                                .map((x) => DropdownMenuItem(
                                      child: Text(x),
                                      value: x,
                                    ))
                                .toList(),
                            onChanged: (selected) {
                              setState(() {
                                _selectedLidSize = selected;
                              });
                            },
                            value: _selectedLidSize,
                            isExpanded: true,
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Box Amount: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 180,
                    child: TextField(
                      controller: _boxAmountCont,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          lastBoxAmount = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Lid Amount: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 180,
                    child: TextField(
                      controller: _lidAmountCont,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          lastLidAmount = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Box Print Price: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 180,
                        child: TextField(
                          controller: _boxPrintPriceCont,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              updatedBoxPrintPrice = value.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'If there is no box print option, enter 0',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lid Print Price: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 180,
                        child: TextField(
                          controller: _lidPrintPriceCont,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              updatedLidPrintPrice = value.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'If there is no Lid print option, enter 0',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Price: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 180,
                    child: TextField(
                      controller: _priceCont,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          updatedPrice = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                child: Text('Update'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text(
                              "Are you sure you want to update this product?"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Yes, I am sure'),
                              onPressed: () {
                                String boxIsprinted = 'no';
                                String lidIsprinted = 'no';
                                if (updatedBoxPrintPrice != "0") {
                                  boxIsprinted = 'yes';
                                }
                                if (updatedLidPrintPrice != "0") {
                                  lidIsprinted = 'yes';
                                }

                                SaleService.updateBoxSale(
                                    widget.saleID,
                                    widget.pID,
                                    _selectedBoxSize,
                                    _selectedLidSize,
                                    lastBoxAmount,
                                    lastLidAmount,
                                    boxIsprinted,
                                    lidIsprinted,
                                    updatedBoxPrintPrice,
                                    updatedLidPrintPrice,
                                    updatedPrice,
                                    widget.proformCount);
                                SaleService.transferSale(widget.saleID,
                                    widget.saleDetail, widget.products);

                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('No, I gave up'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
