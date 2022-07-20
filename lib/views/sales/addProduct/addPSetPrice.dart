import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/saleService.dart';

class AddPSetScreenPrice extends StatefulWidget {
  const AddPSetScreenPrice({
    Key? key,
    required this.productName,
    required this.selectedContent,
    required this.napkinColor,
    required this.napkinColorPrice,
    required this.wetwipesColor,
    required this.wetwipesColorPrice,
    required this.setPiece,
    required this.saleID,
  }) : super(key: key);
  final productName,
      selectedContent,
      napkinColor,
      napkinColorPrice,
      wetwipesColor,
      wetwipesColorPrice,
      setPiece,
      saleID;
  @override
  State<AddPSetScreenPrice> createState() => _AddPSetScreenPriceState();
}

class _AddPSetScreenPriceState extends State<AddPSetScreenPrice> {
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
                    "Enter The Final Price",
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
                                  onPressed: () {
                                    SaleService.newSetSaleProduct(
                                        widget.saleID,
                                        widget.productName,
                                        widget.selectedContent,
                                        widget.napkinColor,
                                        widget.napkinColorPrice,
                                        widget.wetwipesColor,
                                        widget.wetwipesColorPrice,
                                        _finalPriceController.text,
                                        widget.setPiece);
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
