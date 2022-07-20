import 'package:crm_app/services/productService.dart';
import 'package:flutter/material.dart';

import 'editProductBox.dart';

class EditListBoxScreen extends StatefulWidget {
  const EditListBoxScreen({Key? key}) : super(key: key);

  @override
  State<EditListBoxScreen> createState() => _EditListBoxScreenState();
}

class _EditListBoxScreenState extends State<EditListBoxScreen> {
  String? query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text("Set Products"),
          actions: [
            InkWell(
              child: Icon(Icons.refresh),
              onTap: () {
                setState(() {});
              },
            )
          ],
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
                style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search Product',
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
              future: ProductService.getBoxProductTemp(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      if (query != null &&
                          snapshot.data[index]['productName']
                              .toLowerCase()
                              .contains(query)) {
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
                                    child: Icon(Icons.delete,
                                        color: Colors.red, size: 30.0),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Are you sure?'),
                                              content: const Text(
                                                  "Are you sure you want to delete this product?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Yes!'),
                                                  onPressed: () {
                                                    ProductService.deleteBox(
                                                        snapshot.data[index]
                                                            ["productName"]);
                                                    Navigator.of(context).pop();
                                                    //Navigator.of(context).pop();
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
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProductBoxScreen(
                                      productName: snapshot.data[index]
                                          ['productName'],
                                      productType: snapshot.data[index]
                                          ['type'])));
                            });
                          },
                        );
                      } else if (query == null || query == "") {
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
                                    child: Icon(Icons.delete,
                                        color: Colors.red, size: 30.0),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Are you sure?'),
                                              content: const Text(
                                                  "Are you sure you want to delete this product?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Yes!'),
                                                  onPressed: () {
                                                    ProductService.deleteBox(
                                                        snapshot.data[index]
                                                            ["productName"]);
                                                    Navigator.of(context).pop();
                                                    //Navigator.of(context).pop();
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
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProductBoxScreen(
                                      productName: snapshot.data[index]
                                          ['productName'],
                                      productType: snapshot.data[index]
                                          ['type'])));
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
