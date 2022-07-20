import 'package:crm_app/services/saleService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeliveryUpdateScreen extends StatefulWidget {
  const DeliveryUpdateScreen(
      {Key? key, required this.saleID, required this.deliveryPrice})
      : super(key: key);
  final saleID, deliveryPrice;
  @override
  State<DeliveryUpdateScreen> createState() => _DeliveryUpdateScreenState();
}

class _DeliveryUpdateScreenState extends State<DeliveryUpdateScreen> {
  TextEditingController _newDeliveryPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Delivery Price'),
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
                  Text(
                    "Enter The new Delivery Price \n Current Price: ${widget.deliveryPrice}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: _newDeliveryPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Enter the new Delivery price.'),
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
                        ' UPDATE ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ),
                    onTap: () {
                      if (_newDeliveryPriceController.text !=null ||
                          _newDeliveryPriceController.text != '') {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text(
                                    "Are you sure you want to update the price?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      SaleService.updateDeliveryPrice(
                                          widget.saleID,
                                          _newDeliveryPriceController.text);
                                      Navigator.of(context).pop();
                                      setState(() {});
                                      Navigator.of(context).pop(context);
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
                      }
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
