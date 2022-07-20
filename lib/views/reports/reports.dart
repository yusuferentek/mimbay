import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/views/reports/filteredCustomer.dart';
import 'package:crm_app/views/reports/filteredProducts.dart';
import 'package:crm_app/views/sales/sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'filteredPersonal.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReporsScreenState();
}

class _ReporsScreenState extends State<ReportScreen> {
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
        title: const Text('Select Date'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade800),
                      onPressed: () {
                        _selectStartDate(context);
                      },
                      child: Text('Choose Start Date')),
                  Text(
                      "${selectedStartDate.day}/${selectedStartDate.month}/${selectedStartDate.year}"),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade800),
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
                      onPressed: () {
                        setState(() {
                          if (selectedStartDate.compareTo(selectedEndDate) >
                              0) {
                            print('true');
                          }
                          SaleService.findBests(
                              selectedStartDate, selectedEndDate);
                          showData = true;
                        });
                      },
                      child: const Text('Show Datas')),
                  showData == true
                      ? FutureBuilder<dynamic>(
                          future: SaleService.findBests(
                              selectedStartDate, selectedEndDate),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: 380,
                                    height: 80,
                                    //decoration: BoxDecoration(color: Colors.),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Colors.green.shade600,
                                      child: Row(children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                'Best Customer: ${snapshot.data['bestCustomer']}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Action Taken: ${snapshot.data['customerCount']}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 90,
                                        ),
                                        InkWell(
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.green.shade700,
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/arrow_right.png"),
                                                )),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FilteredCustomerScreen(
                                                            startDate:
                                                                selectedStartDate,
                                                            endDate:
                                                                selectedEndDate)));
                                          },
                                        )
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: 380,
                                    height: 80,
                                    //decoration: BoxDecoration(color: Colors.),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Colors.green.shade600,
                                      child: Row(children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                'Best Product: ${snapshot.data['bestProduct']}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Action Taken: ${snapshot.data['productCount']}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 90,
                                        ),
                                        InkWell(
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.green.shade700,
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/arrow_right.png"),
                                                )),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FilteredProductsScren(
                                                            startDate:
                                                                selectedStartDate,
                                                            endDate:
                                                                selectedEndDate)));
                                          },
                                        )
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: 380,
                                    height: 80,
                                    //decoration: BoxDecoration(color: Colors.),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Colors.green.shade600,
                                      child: Row(children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                'Best Personal: ${snapshot.data['bestPersonal']}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Action Taken: ${snapshot.data['personalCount']}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 90,
                                        ),
                                        InkWell(
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.green.shade700,
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/arrow_right.png"),
                                                )),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FilteredPersonalScreen(
                                                            startDate:
                                                                selectedStartDate,
                                                            endDate:
                                                                selectedEndDate)));
                                          },
                                        )
                                      ]),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
