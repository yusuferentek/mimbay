import 'package:crm_app/models/userModel.dart';
import 'package:crm_app/services/customerService.dart';
import 'package:crm_app/views/customer/customerReport.dart';
import 'package:crm_app/views/customer/updateCustomer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerDetailScreen extends StatefulWidget {
  const CustomerDetailScreen({Key? key, required this.customerID})
      : super(key: key);
  final customerID;
  @override
  _CustomerDetailScreenState createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  DateTime firstDate = DateTime(2000);
  bool showData = false;
  _selectStartDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedStartDate) {
      setState(() {
        selectedStartDate = selected;
      });
    }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedEndDate) {
      setState(() {
        selectedEndDate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text('Detail'),
          actions: [
            const SizedBox(
              width: 10,
            ),
            FutureBuilder<dynamic>(
              future: CustomerService.getCustomerDetail(widget.customerID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    child: Icon(Icons.edit),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateCustomerScreen(
                              compName: snapshot.data[0]['companyName'],
                              compPhone: snapshot.data[0]['companyPhone'],
                              compAddress: snapshot.data[0]['companyAddress'],
                              authName: snapshot.data[0]['authName'],
                              authPhone: snapshot.data[0]['authPhone'],
                              customerRef: snapshot.data[0]['customerRef'],
                              compPostCode: snapshot.data[0]['postCode'])));
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              child: Icon(Icons.delete),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text(
                            "Are you sure you want to delete this customer?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Yes!'),
                            onPressed: () {
                              CustomerService.deleteCustomer(widget.customerID);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
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
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: FutureBuilder<dynamic>(
            future: CustomerService.getCustomerDetail(widget.customerID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(58, 66, 86, 1.0),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${snapshot.data[0]['companyName']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${snapshot.data[0]['authName']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: AnnotatedRegion<SystemUiOverlayStyle>(
                      value: SystemUiOverlayStyle.light,
                      child: GestureDetector(
                        onTap: (() => FocusScope.of(context).unfocus()),
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Company Address: ${snapshot.data[0]['companyAddress']}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                      "Company Post Code: ${snapshot.data[0]['postCode']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                      "Company Phone: ${snapshot.data[0]['companyPhone']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                      "Auth Phone: ${snapshot.data[0]['authPhone']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                      "Customer Reference: ${snapshot.data[0]['customerRef']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  userModel.userRole == 'admin'
                                      ? Column(
                                          children: [
                                            Divider(thickness: 2),
                                            const Text('Reports',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red)),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.orange.shade800),
                                                onPressed: () {
                                                  _selectStartDate(context);
                                                },
                                                child:
                                                    Text('Choose Start Date')),
                                            Text(
                                                "${selectedStartDate.day}/${selectedStartDate.month}/${selectedStartDate.year}"),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.orange.shade800),
                                                onPressed: () {
                                                  _selectEndDate(context);
                                                },
                                                child: Text('Choose End Date')),
                                            Text(
                                                "${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}"),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  List<dynamic> names =
                                                      await CustomerService
                                                          .getCustomerReportsPname(
                                                              widget.customerID,
                                                              selectedStartDate,
                                                              selectedEndDate);
                                                  List<dynamic> counts =
                                                      await CustomerService
                                                          .getCustomerReportsPcount(
                                                              widget.customerID,
                                                              selectedStartDate,
                                                              selectedEndDate);
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CustomerReportScreen(
                                                                  pNames: names,
                                                                  pCounts:
                                                                      counts)));
                                                },
                                                child: const Text(
                                                    'Go Customer Reports')),
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
