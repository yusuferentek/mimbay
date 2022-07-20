import 'package:crm_app/models/userModel.dart';
import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SinglePriceScreen extends StatefulWidget {
  const SinglePriceScreen(
      {Key? key,
      required this.total,
      required this.customerName,
      required this.deliveryPrice,
      required this.productColor,
      required this.productColorPrice,
      required this.productName,
      required this.productSize,
      required this.piece})
      : super(key: key);
  final total;
  final customerName;
  final deliveryPrice;
  final productColor;
  final productColorPrice;
  final productName;
  final productSize;
  final piece;

  @override
  State<SinglePriceScreen> createState() => _SinglePriceScreenState();
}

class _SinglePriceScreenState extends State<SinglePriceScreen> {
  TextEditingController _priceController = TextEditingController();
  var lastTotal;
  
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
                                  onPressed: () async {
                                    String deliveryPrice = "0";
                                    if (widget.deliveryPrice != null ||
                                        widget.deliveryPrice != "") {
                                      deliveryPrice = widget.deliveryPrice;
                                    }
                                    var shared =
                                        await SharedPreferences.getInstance();
                                    SaleService.createSingleSale(
                                        widget.total,
                                        widget.customerName,
                                        deliveryPrice,
                                        shared.getString('username'),
                                        widget.productColor,
                                        widget.productColorPrice,
                                        widget.productName,
                                        widget.productSize,
                                        _priceController.text,
                                        widget.piece);
                                    
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
