// ignore_for_file: deprecated_member_use

import 'package:crm_app/services/customerService.dart';
import 'package:crm_app/utilities/constans.dart';
import 'package:crm_app/views/customer/addCustomer.dart';
import 'package:crm_app/views/customer/customerDeatil.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  String? query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Customers"),
        actions: [
          InkWell(
            child: Container(
                width: 50,
                child: Icon(
                  Icons.add,
                  size: 30,
                )),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddCustomerScreen()));
            },
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black, width: 1.5))),
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
              hintText: 'Search Customer',
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
        //SizedBox(height: 10,),
        Expanded(
          child: FutureBuilder<dynamic>(
            future: CustomerService.getCustomerTemp(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                
                return FutureBuilder<dynamic>(
                    future: CustomerService.getCustomerID(),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            if (query != null &&
                                snapshot.data[index]['companyName']
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
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                        leading: Container(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          decoration: new BoxDecoration(
                                              border: new Border(
                                                  right: new BorderSide(
                                                      width: 1.0,
                                                      color: Colors.white24))),
                                          child: Icon(Icons.location_city,
                                              color: Colors.white),
                                        ),
                                        title: Text(
                                          "${snapshot.data[index]['companyName']}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                        subtitle: Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                                "${snapshot.data[index]["authName"]}",
                                                style: TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                        trailing: const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                            size: 30.0)),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerDetailScreen(
                                            customerID:
                                                snapshots.data[index].id,
                                          )));
                                },
                              );
                            } else if(query == null || query == "") {
                              return InkWell(
                                child: Card(
                                  elevation: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(64, 75, 96, .9)),
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                        leading: Container(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          decoration:const  BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.white24))),
                                          child: const Icon(Icons.location_city,
                                              color: Colors.white),
                                        ),
                                        title: Text(
                                          "${snapshot.data[index]['companyName']}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                        subtitle: Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                                "${snapshot.data[index]["authName"]}",
                                                style: TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                        trailing: const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                            size: 30.0)),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerDetailScreen(
                                            customerID:
                                                snapshots.data[index].id,
                                          )));
                                },
                              );
                            }else {
                              return Center();
                            }
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}
