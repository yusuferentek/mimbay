import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/widgets/selectContent.dart';
import 'package:flutter/material.dart';

class AddProformSetScreen extends StatefulWidget {
  const AddProformSetScreen(
      {Key? key,
      required this.saleID,
      required this.selectedContent,
      required this.napkinColor,
      required this.napkinColorPrice,
      required this.wetwipesColor,
      required this.wetwipesColorPrice,
      required this.setPrice,
      required this.setAmount,
      required this.customerName,
      required this.productName,
      required this.proformCount,
      required this.pID,
      required this.saleDetail,
      required this.products})
      : super(key: key);
  final saleID,
      selectedContent,
      napkinColor,
      napkinColorPrice,
      wetwipesColor,
      wetwipesColorPrice,
      setPrice,
      setAmount,
      customerName,
      productName,
      pID,
      proformCount,
      saleDetail,
      products;
  @override
  State<AddProformSetScreen> createState() => _AddProformSetScreenState();
}

class _AddProformSetScreenState extends State<AddProformSetScreen> {
  List<String> abc = [];

  var _selectedNapkinColor;
  var _selectedWetwipesColor;
  TextEditingController _napkinColorPriceCont = new TextEditingController();
  TextEditingController _wetwipesColorPriceCont = new TextEditingController();
  TextEditingController _priceCont = new TextEditingController();
  TextEditingController _amountCont = new TextEditingController();
  List<String> _selectedItems = [];
  var napkinColorPriceText, wetwipesColorPriceText, amountText, priceText;
  void initState() {
    for (int i = 0; i < widget.selectedContent.length; i++) {
      abc.add(widget.selectedContent[i].toString());
    }
    _selectedItems.addAll(abc);
    _selectedNapkinColor = widget.napkinColor;
    _selectedWetwipesColor = widget.wetwipesColor;
    _napkinColorPriceCont.text = widget.napkinColorPrice.toString();
    _wetwipesColorPriceCont.text = widget.wetwipesColorPrice.toString();
    _priceCont.text = widget.setPrice.toString();
    _amountCont.text = widget.setPrice.toString();
    super.initState();
  }

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
      appBar: AppBar(title: Text('Add Proform')),
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
                    'Selected Contents: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<dynamic>(
                    future: SaleService.getSetSelectedContents(
                        widget.saleID, widget.pID),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('${snapshot.data.toString()}');
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
              FutureBuilder<dynamic>(
                future: SaleService.getSetContent(widget.productName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String> contents = [];
                    for (int i = 0; i < snapshot.data.length; i++) {
                      contents.add(snapshot.data[i]);
                    }
                    return ElevatedButton(
                        onPressed: () {
                          _showMultiSelect(contents);
                        },
                        child: Text('Update Contents'));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Napkin Color: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<dynamic>(
                    future: SaleService.getSetNapkinColor(widget.productName),
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
                                _selectedNapkinColor = selected;
                              });
                            },
                            value: _selectedNapkinColor,
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
                    'Napkin Color Price: ',
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
                          controller: _napkinColorPriceCont,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              napkinColorPriceText = value.toString();
                            });
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
                  Text(
                    'Wetwipes Color: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<dynamic>(
                    future: SaleService.getSetNapkinColor(widget.productName),
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
                                _selectedWetwipesColor = selected;
                              });
                            },
                            value: _selectedWetwipesColor,
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
                    'Wetwipes Color Price: ',
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
                          controller: _wetwipesColorPriceCont,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              wetwipesColorPriceText = value.toString();
                            });
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
                  Text(
                    'Amount: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 180,
                    child: TextField(
                      controller: _amountCont,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          amountText = value.toString();
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
                          priceText = value.toString();
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
                child: Text(' UPDATE  '),
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
                                if (_selectedItems == [] ||
                                    _selectedItems == null) {
                                  _selectedItems = widget.selectedContent;
                                }

                                SaleService.updateSetSale(
                                    widget.saleID,
                                    widget.pID,
                                    _selectedItems,
                                    _selectedNapkinColor,
                                    napkinColorPriceText ??
                                        widget.napkinColorPrice,
                                    wetwipesColorPriceText ??
                                        widget.wetwipesColorPrice,
                                    _selectedWetwipesColor,
                                    amountText ?? widget.setAmount,
                                    priceText ?? widget.setPrice,
                                    widget.proformCount);
                                SaleService.transferSale(widget.saleID,
                                    widget.saleDetail, widget.products);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
