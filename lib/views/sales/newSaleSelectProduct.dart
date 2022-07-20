import 'package:crm_app/services/productService.dart';
import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/views/sales/newSaleBox.dart';
import 'package:crm_app/views/sales/newSaleSet.dart';
import 'package:crm_app/views/sales/newSaleSingle.dart';
import 'package:flutter/material.dart';

class NewSaleSelectProducts extends StatefulWidget {
  const NewSaleSelectProducts({Key? key}) : super(key: key);

  @override
  State<NewSaleSelectProducts> createState() => _NewSaleSelectProductsState();
}

class _NewSaleSelectProductsState extends State<NewSaleSelectProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Choose Product')),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder<dynamic>(
              future: ProductService.getAllProductTemp(),
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
                                    image: AssetImage("assets/images/box.png"),
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
                            ),
                          ),
                        ),
                        onTap: () {
                          if (snapshot.data[index]["type"] == "single") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NewSaleSingleScreen()));
                          } else if (snapshot.data[index]["type"] == "set") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NewSaleSetScreen()));
                          } else if (snapshot.data[index]["type"] == "box") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NewSaleBoxScreen()));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: Text("Please contact app creator!"),
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
