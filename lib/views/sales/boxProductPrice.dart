import 'package:crm_app/models/userModel.dart';
import 'package:crm_app/services/saleService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoxProductPriceScreen extends StatefulWidget {
  const BoxProductPriceScreen(
      {Key? key,
      required this.productName,
      required this.customerName,
      required this.boxAmount,
      required this.lidAmount,
      required this.lidIsPrinted,
      required this.boxIsPrinted,
      required this.boxSize,
      required this.lidSize,
      required this.boxPrintPrice,
      required this.lidPrintPrice,
      required this.deliveryIsSelected,
      required this.deliveryPrice})
      : super(key: key);
  final productName,
      customerName,
      boxAmount,
      lidAmount,
      lidIsPrinted,
      boxIsPrinted,
      boxSize,
      lidSize,
      boxPrintPrice,
      lidPrintPrice,
      deliveryIsSelected,
      deliveryPrice;
  @override
  State<BoxProductPriceScreen> createState() => _BoxProductPriceScreenState();
}

class _BoxProductPriceScreenState extends State<BoxProductPriceScreen> {
  double boxPrice = 0;
  double lidPrice = 0;
  double lidAmount = 0;
  double boxAmount = 0;
  double boxPrintPrice = 0;
  double lidPrintPrice = 0;
  double deliveryPrice = 0;
  double sonuc = 0;
  var lastPrices;
  var sonucString;
  void initState() {
    //box Price convertion
    String boxPriceString = widget.boxSize;
    boxPriceString = boxPriceString.substring(boxPriceString.indexOf(':') + 1);
    var unitPrices = boxPriceString.split(';');
    String piece = widget.boxAmount;
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
    } else if (_piece > 100000) {
      sP = unitPrices[4];
    }

    boxPrice = double.parse(sP);
    // lid Price convertion
    String lidPriceString = widget.lidSize;
    lidPriceString = lidPriceString.substring(lidPriceString.indexOf(':') + 1);
    var unitPricesL = lidPriceString.split(';');
    String pieceL = widget.boxAmount;
    int _pieceL = int.parse(pieceL);
    var sPL;
    
    if (_pieceL < 10000) {
      sPL = unitPricesL[0];
    } else if (_pieceL < 20000) {
      sPL = unitPricesL[1];
    } else if (_pieceL > 20000) {
      sPL = unitPricesL[2];
    } else if (_pieceL > 50000) {
      sPL = unitPricesL[3];
    } else if (_pieceL > 100000){
      sPL = unitPricesL[4];
    }

    lidPrice = double.parse(sPL);
    // tanımlamalar
    boxAmount = double.parse(widget.boxAmount);
    lidAmount = double.parse(widget.lidAmount);
    if (widget.boxIsPrinted == true) {
      boxPrintPrice = double.parse(widget.boxPrintPrice);
    }
    if (widget.lidIsPrinted == true) {
      lidPrintPrice = double.parse(widget.lidPrintPrice);
    }
    if (widget.deliveryIsSelected == true) {
      deliveryPrice = double.parse(widget.deliveryPrice);
    }
    // işlemler
    sonuc = (boxPrice * boxAmount) +
        (lidPrice * lidAmount) +
        boxPrintPrice +
        lidPrintPrice;
    sonucString = sonuc.toStringAsFixed(2);
    
    //sonucString = sonucString.substring(0, dotIndex + 3);
    super.initState();
  }

  TextEditingController _lastPriceCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete the New Sale(not include delivery fee)'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                  ),
                  Text(
                    'Default Price: $sonucString',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 250,
                    child: TextField(
                      controller: _lastPriceCont,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'input the final price'),
                      onChanged: (value) {
                        lastPrices = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                content: Text(
                                    "Are you sure you want to complete the sale?."),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () async {
                                      String deliveryPrice = "0";
                                      if (widget.deliveryPrice != null ||
                                          widget.deliveryPrice != '') {
                                        deliveryPrice = widget.deliveryPrice;
                                      }
                                      String boxPrintPrice = "0";
                                      if (widget.boxPrintPrice != null) {
                                        boxPrintPrice = widget.boxPrintPrice;
                                      }
                                      String lidPrintPrice = "0";
                                      if (widget.lidPrintPrice != null) {
                                        lidPrintPrice = widget.lidPrintPrice;
                                      }
                                      var shared =
                                          await SharedPreferences.getInstance();
                                      SaleService.createBoxSale(
                                          sonucString,
                                          widget.customerName,
                                          widget.productName,
                                          widget.boxAmount,
                                          widget.lidAmount,
                                          widget.boxSize,
                                          widget.lidSize,
                                          widget.boxIsPrinted,
                                          widget.lidIsPrinted,
                                          boxPrintPrice,
                                          lidPrintPrice,
                                          deliveryPrice,
                                          lastPrices,
                                          shared.getString('username'));
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No'))
                                ],
                              );
                            });
                      },
                      child: Text('Complete The Sale'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
