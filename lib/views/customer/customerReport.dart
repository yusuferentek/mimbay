import 'package:crm_app/views/product/productDetail.dart';
import 'package:flutter/material.dart';

class CustomerReportScreen extends StatefulWidget {
  const CustomerReportScreen(
      {Key? key, required this.pNames, required this.pCounts})
      : super(key: key);
  final pNames, pCounts;
  @override
  State<CustomerReportScreen> createState() => _CustomerReportScreenState();
}

class _CustomerReportScreenState extends State<CustomerReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text("Filtered Products"),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.pNames.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: const EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: new BorderSide(
                                        width: 1.0, color: Colors.white24))),
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
                            "${widget.pNames[index]['productName']}",
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
                              const SizedBox(
                                width: 5,
                              ),
                              Text("${widget.pCounts[index]}",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right,
                              color: Colors.white, size: 30.0)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                            productName: widget.pNames[index]['productName'],
                            productType: widget.pNames[index]['type'])));
                  },
                );
              },
            ))
          ],
        ));
  }
}
