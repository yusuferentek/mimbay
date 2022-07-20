import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/views/sales/saleDetail.dart';
import 'package:crm_app/views/sales/saleDetailMulti.dart';
import 'package:flutter/material.dart';

class SaleListScreen extends StatefulWidget {
  const SaleListScreen({Key? key}) : super(key: key);

  @override
  State<SaleListScreen> createState() => _SaleListScreenState();
}

class _SaleListScreenState extends State<SaleListScreen> {
  String? query;

  @override
  Widget build(BuildContext context) {
    var state;

    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text("Sales"),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1.5))),
              height: 60.0,
              child: TextField(
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search Sales',
                  hintStyle:
                      TextStyle(color: Colors.white54, fontFamily: 'OpenSans'),
                ),
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
            ),
            Expanded(
                child: FutureBuilder<dynamic>(
              future: SaleService.getAllSale(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      if (query != null &&
                          (snapshot.data[index]['saleID']
                              .toLowerCase()
                              .contains(query))) {
                        if (snapshot.data[index]['isChecked'] == true) {
                          state = 'Invoice';
                        }
                        if (snapshot.data[index]['isChecked'] == false) {
                          state = 'Proforma';
                        }
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
                                    "${snapshot.data[index]["saleID"]}",
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
                                      Text(state,
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  trailing: const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.white,
                                      size: 30.0)),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SaleDetailMultiScreen(
                                        saleID: snapshot.data[index].id,
                                        customerName: snapshot.data[index]
                                            ['customerName'],
                                      )));
                            });
                          },
                        );
                      } else if (query == null || query == "") {
                        if (snapshot.data[index]['isChecked'] == true) {
                          state = 'Invoice';
                        }
                        if (snapshot.data[index]['isChecked'] == false) {
                          state = 'Proforma';
                        }
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
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
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
                                    "${snapshot.data[index]["saleID"]}",
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
                                      Text(state,
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  trailing: const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.white,
                                      size: 30.0)),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SaleDetailMultiScreen(
                                        saleID: snapshot.data[index].id,
                                        customerName: snapshot.data[index]
                                            ['customerName'],
                                      )));
                            });
                          },
                        );
                      } else {
                        return Center();
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ))
          ],
        ));
  }
}
