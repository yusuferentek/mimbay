import 'package:crm_app/services/saleService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPSinglePrice extends StatefulWidget {
  const AddPSinglePrice({
    Key? key,
    required this.saleID,
    required this.productColor,
    required this.productColorPrice,
    required this.productName,
    required this.productSize,
    required this.piece,
    required this.total,
  }) : super(key: key);
  final productColor;
  final productColorPrice;
  final productName;
  final productSize;
  final saleID;
  final piece;
  final total;
  @override
  State<AddPSinglePrice> createState() => _AddPSinglePriceState();
}

class _AddPSinglePriceState extends State<AddPSinglePrice> {
  TextEditingController _priceController = TextEditingController();
  double total = 0;
  

  
  int cPrice = 0;
  /*void initState() {
    String sPriceString =
        widget.productSize.substring(widget.productSize.indexOf(':') + 1);

    double sPrice = double.parse(sPriceString);
    if (widget.productColor != "none") {
      cPrice =
          int.parse(widget.productColorPrice) * int.parse(widget.productColor);
    }
    int amount = int.parse(widget.piece);
    total = (sPrice * amount) + cPrice;
    setState(() {});
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete the New Product'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Default Price: £${widget.total.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: 'Enter the final price.'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    child: Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                          color: Colors.blueGrey),
                      child: Center(
                          child: Text(
                        'Continue the Sale',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ),
                    onTap: () {
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
                                  onPressed: () {
                                    SaleService.newSingleSaleProduct(
                                        total,
                                        widget.saleID,
                                        widget.productColor,
                                        widget.productColorPrice,
                                        widget.productName,
                                        widget.productSize,
                                        _priceController.text,
                                        widget.piece);
                                    Navigator.of(context).pop();
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
