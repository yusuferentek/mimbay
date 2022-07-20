import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/views/sales/sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceNr extends StatefulWidget {
  const InvoiceNr({Key? key}) : super(key: key);

  @override
  State<InvoiceNr> createState() => _InvoiceNrState();
}

class _InvoiceNrState extends State<InvoiceNr> {
  TextEditingController _invoiceController = new TextEditingController();
  var lastInvoice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update The Invoice Number'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(
              child: FutureBuilder<dynamic>(
                future: SaleService.getInvoiceNumber(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.30,
                        ),
                        Text(
                          'Current Number: ${snapshot.data}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 250,
                          child: TextField(
                            controller: _invoiceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'input the new Invoice Number'),
                            onChanged: (value) {
                              lastInvoice = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Are you sure?'),
                                      content: const Text(
                                          "Are you sure you want to update the Invoice Number?."),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Yes'),
                                          onPressed: () async {
                                            int invNumb = int.parse(lastInvoice);
                                            SaleService.updateInvoiceNumber(invNumb);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            
                                          },
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('No'))
                                      ],
                                    );
                                  });
                            },
                            child: const Text('Update The Invoice Number'))
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
