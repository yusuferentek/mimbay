import 'package:crm_app/views/sales/addProformSet.dart';
import 'package:crm_app/views/sales/addProformSingle.dart';
import 'package:crm_app/views/sales/addRecentBox.dart';
import 'package:flutter/material.dart';

import '../../services/saleService.dart';

class UpdateSaleSelectProductScreen extends StatefulWidget {
  const UpdateSaleSelectProductScreen(
      {Key? key,
      required this.saleID,
      required this.customerName,
      required this.proformCount,
      required this.saleDetail,
      required this.products})
      : super(key: key);
  final saleID, customerName, proformCount, saleDetail, products;
  @override
  State<UpdateSaleSelectProductScreen> createState() =>
      _UpdateSaleSelectProductScreenState();
}

class _UpdateSaleSelectProductScreenState
    extends State<UpdateSaleSelectProductScreen> {
  var _selectedP;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Choose Product')),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder<dynamic>(
              future: SaleService.getSaleProducts(widget.saleID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Card(
                          elevation: 8.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9)),
                            child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: new BorderSide(
                                              width: 1.0,
                                              color: Colors.white24))),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/box.png"),
                                    )),
                                  ),
                                ),
                                title: Text(
                                  "${snapshot.data[index]["productName"]}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Row(
                                  children: [
                                    const Icon(
                                      Icons.widgets,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("${snapshot.data[index]["type"]}",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                                trailing: InkWell(
                                  child: const Icon(Icons.delete,
                                      color: Colors.red, size: 30.0),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Alert'),
                                            content: Text(
                                                "Are you sure you want to remove the product for sale?"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Yes'),
                                                onPressed: () {
                                                  setState(() {
                                                    SaleService
                                                        .deleteSaleProduct(
                                                            widget.saleID,
                                                            snapshot.data[index]
                                                                .id);
                                                  });
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('No'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                )),
                          ),
                        ),
                        onTap: () {
                          if (snapshot.data[index]["type"] == 'single') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddProformScreenSingle(
                                      saleID: widget.saleID,
                                      productSize: snapshot.data[index]
                                          ["productSize"],
                                      productColor: snapshot.data[index]
                                          ["productColor"],
                                      productColorPrice: snapshot.data[index]
                                          ["productColorPrice"],
                                      productPrice: snapshot.data[index]
                                          ["price"],
                                      productPiece: snapshot.data[index]
                                          ["piece"],
                                      customerName: widget.customerName,
                                      productName: snapshot.data[index]
                                          ["productName"],
                                      proformCount: widget.proformCount,
                                      pID: snapshot.data[index].id,
                                      saleDetail: widget.saleDetail,
                                      products: widget.products,
                                    )));
                          } else if (snapshot.data[index]["type"] == 'set') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddProformSetScreen(
                                      saleID: widget.saleID,
                                      selectedContent: snapshot.data[index]
                                          ["selectedContent"],
                                      napkinColor: snapshot.data[index]
                                          ["napkinColor"],
                                      napkinColorPrice: snapshot.data[index]
                                          ["napkinColorPrice"],
                                      wetwipesColor: snapshot.data[index]
                                          ["wetwipesColor"],
                                      wetwipesColorPrice: snapshot.data[index]
                                          ["wetwipesColorPrice"],
                                      setPrice: snapshot.data[index]["price"],
                                      setAmount: snapshot.data[index]["piece"],
                                      customerName: widget.customerName,
                                      productName: snapshot.data[index]
                                          ["productName"],
                                      proformCount: widget.proformCount,
                                      pID: snapshot.data[index].id,
                                      saleDetail: widget.saleDetail,
                                      products: widget.products,
                                    )));
                          } else if (snapshot.data[index]["type"] == 'box') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddRecentBoxScreen(
                                      customerName: widget.customerName,
                                      productName: snapshot.data[index]
                                          ["productName"],
                                      saleID: widget.saleID,
                                      boxSize: snapshot.data[index]["boxSize"],
                                      lidSize: snapshot.data[index]["lidSize"],
                                      boxAmount: snapshot.data[index]
                                          ["boxAmount"],
                                      lidAmount: snapshot.data[index]
                                          ["lidAmount"],
                                      boxIsPrinted: snapshot.data[index]
                                          ["boxIsPrinted"],
                                      lidIsPrinted: snapshot.data[index]
                                          ["lidIsPrinted"],
                                      boxPrintPrice: snapshot.data[index]
                                          ["boxPrintPrice"],
                                      lidPrintPrice: snapshot.data[index]
                                          ["lidPrintPrice"],
                                      pID: snapshot.data[index].id,
                                      lastPrice: snapshot.data[index]["price"],
                                      proformCount: widget.proformCount,
                                      saleDetail: widget.saleDetail,
                                      products: widget.products,
                                    )));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: Text("Please Choose a Category"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          //setState(() {});
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
          ],
        )
        /*
              */

        );
  }
}
