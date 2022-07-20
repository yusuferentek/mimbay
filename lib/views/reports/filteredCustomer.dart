import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/views/customer/customerDeatil.dart';
import 'package:flutter/material.dart';

class FilteredCustomerScreen extends StatefulWidget {
  const FilteredCustomerScreen(
      {Key? key, required this.startDate, required this.endDate})
      : super(key: key);
  final startDate, endDate;
  @override
  State<FilteredCustomerScreen> createState() => _FilteredCustomerScreenState();
}

class _FilteredCustomerScreenState extends State<FilteredCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text("Filtered Customers"),
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder<dynamic>(
              future: SaleService.getFilteredCustomerNames(
                  widget.startDate, widget.endDate),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder<dynamic>(
                    future: SaleService.getFilteredCustomerCount(
                        widget.startDate, widget.endDate),
                    builder: (context, snapshotCount) {
                      if (snapshotCount.hasData) {
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                      leading: Container(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
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
                                            image: AssetImage(
                                                "assets/images/customer.png"),
                                          )),
                                        ),
                                      ),
                                      title: Text(
                                        "${snapshot.data[index]['customerName']}",
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
                                          Text("${snapshotCount.data[index]}",
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
                                    builder: (context) => CustomerDetailScreen(
                                        customerID: snapshot.data[index]
                                            ['customerName'])));
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
