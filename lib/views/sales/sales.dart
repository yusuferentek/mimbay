import 'package:crm_app/views/sales/chooseCategory.dart';
import 'package:crm_app/views/sales/newSaleSelectProduct.dart';
import 'package:crm_app/views/sales/newSaleSingle.dart';
import 'package:crm_app/views/sales/salesList.dart';
import 'package:flutter/material.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);

  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Sales"),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  color: Colors.green.shade800,
                  width: 150,
                  height: 150,
                  child: Row(children: const [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.add_shopping_cart),
                    VerticalDivider(
                      indent: 65,
                      endIndent: 65,
                      thickness: 1.5,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "New Sale",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    )
                  ]),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewSaleSelectProducts()));
                },
              ),
              const SizedBox(
                width: 50,
              ),
              InkWell(
                child: Container(
                  color: Colors.yellow.shade900,
                  width: 150,
                  height: 150,
                  child: Row(children: const [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.shopping_cart),
                    VerticalDivider(
                      indent: 65,
                      endIndent: 65,
                      thickness: 1.5,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Sales",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    )
                  ]),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SaleListScreen()));
                },
              ),
            ],
          ),
        ));
  }
}
