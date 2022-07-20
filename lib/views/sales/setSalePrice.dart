import 'package:crm_app/models/userModel.dart';
import 'package:crm_app/services/saleService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetSalePriceScreen extends StatefulWidget {
  const SetSalePriceScreen(
      {Key? key,
      required this.productName,
      required this.selectedContent,
      required this.napkinColor,
      required this.napkinColorPrice,
      required this.wetwipesColor,
      required this.wetwipesColorPrice,
      required this.customerName,
      required this.setPiece,
      required this.deliveryPrice})
      : super(key: key);
  final productName,
      selectedContent,
      napkinColor,
      napkinColorPrice,
      wetwipesColor,
      wetwipesColorPrice,
      customerName,
      setPiece,
      deliveryPrice;

  @override
  State<SetSalePriceScreen> createState() => _SetSalePriceScreenState();
}

class _SetSalePriceScreenState extends State<SetSalePriceScreen> {
  TextEditingController _finalPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete the New Sale(Proform)'),
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
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    "Enter The Final Price (not include delivery fee)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: _finalPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Enter the final price.'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    child: Container(
                      width: 200,
                      height: 30,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                          color: Colors.blueGrey),
                      child: const Center(
                          child: Text(
                        'Complete the Sale',
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
                              content: const Text(
                                  "Are you sure you want to complete the sale?."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () async {
                                    String deliveryPrice = "0";
                                    if (await widget.deliveryPrice != null) {
                                      deliveryPrice = widget.deliveryPrice;
                                    }
                                    String napkinColorPrice = "0";
                                    if (widget.napkinColorPrice != null) {
                                      napkinColorPrice =
                                          widget.napkinColorPrice;
                                    }
                                    String wetwipesColorPrice = "0";
                                    if (widget.wetwipesColorPrice != null) {
                                      wetwipesColorPrice =
                                          widget.wetwipesColorPrice;
                                    }
                                    var shared =
                                        await SharedPreferences.getInstance();
                                    SaleService.createSetSale(
                                        _finalPriceController.text,
                                        shared.getString('username'),
                                        widget.customerName,
                                        widget.productName,
                                        widget.selectedContent,
                                        widget.napkinColor,
                                        napkinColorPrice,
                                        widget.wetwipesColor,
                                        wetwipesColorPrice,
                                        _finalPriceController.text,
                                        widget.setPiece,
                                        deliveryPrice);
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
