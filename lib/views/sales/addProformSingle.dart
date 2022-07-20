import 'package:flutter/material.dart';

import '../../services/saleService.dart';

class AddProformScreenSingle extends StatefulWidget {
  const AddProformScreenSingle(
      {Key? key,
      required this.saleID,
      required this.productSize,
      required this.productColor,
      required this.productColorPrice,
      required this.productPrice,
      required this.productPiece,
      required this.customerName,
      required this.productName,
      required this.proformCount,
      required this.pID,
      required this.saleDetail,
      required this.products})
      : super(key: key);
  final saleID,
      productSize,
      productColor,
      productColorPrice,
      productPrice,
      productPiece,
      customerName,
      productName,
      proformCount,
      pID,
      saleDetail,
      products;
  @override
  State<AddProformScreenSingle> createState() => _AddProformScreenSingleState();
}

class _AddProformScreenSingleState extends State<AddProformScreenSingle> {
  TextEditingController _pieceCont = TextEditingController();
  TextEditingController _priceCont = TextEditingController();
  TextEditingController _colorCont = TextEditingController();
  TextEditingController _colorPriceCont = TextEditingController();
  TextEditingController _sizeCont = TextEditingController();

  var _selectedSize;
  var _selectedColor;
  var _colorPrice;
  var colorPriceText, priceText, pieceText;
  void initState() {
    _selectedSize = widget.productSize;
    _selectedColor = widget.productColor;
    _colorPriceCont.text = widget.productColorPrice.toString();
    _pieceCont.text = widget.productPiece.toString();
    _priceCont.text = widget.productPrice.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Proform'),
      ),
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).unfocus()),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Customer Name: ${widget.customerName}",
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Product Name: ${widget.productName}",
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
                    'Product Size: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<dynamic>(
                    future: SaleService.getSingleSize(widget.productName),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> sizes = [];
                        for (int i = 0; i < snapshot.data.length; i++) {
                          sizes.add(snapshot.data[i]);
                        }
                        return Container(
                          width: 150,
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
                  Text(
                    'Product Color: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<dynamic>(
                    future: SaleService.getSingleColor(widget.productName),
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
                                _selectedColor = selected;
                              });
                            },
                            value: _selectedColor,
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
                  Text(
                    'Product Color Price: ',
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
                          controller: _colorPriceCont,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            colorPriceText = value.toString();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'If there is no color option, enter 1',
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
                  const Text(
                    'Product Amount: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 180,
                    child: TextField(
                      controller: _pieceCont,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        pieceText = value.toString();
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
                    'Product Price: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 180,
                    child: TextField(
                      controller: _priceCont,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        priceText = value.toString();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
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
                                  
                                  SaleService.updateSingleSale(
                                      _selectedColor ?? widget.productColor,
                                      colorPriceText ??
                                          widget.productColorPrice,
                                      _selectedSize,
                                      priceText ?? widget.productPrice,
                                      pieceText ?? widget.productPiece,
                                      widget.saleID,
                                      widget.proformCount,
                                      widget.pID);
                                  SaleService.transferSale(
                                      widget.saleID,widget.saleDetail, widget.products);
                                  Navigator.of(context).pop();

                                  Navigator.of(context).pop();
                                  setState(() {});
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
                  child: Text('UPDATE'))
            ],
          ),
        ),
      ),
    );
  }
}
