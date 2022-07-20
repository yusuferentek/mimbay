import 'package:crm_app/pdf/pdf_page.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart' as material;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../services/customerService.dart';

orderPdfViewProform(
    context, customerI, productI, saleID, customerName, saleI) async {
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/images/mimbayLogo.jpg'))
        .buffer
        .asUint8List(),
  );
  Map<int, TableColumnWidth>? columnWidths = <int, TableColumnWidth>{
    0: const FlexColumnWidth(0.625),
    1: const FlexColumnWidth(2.5),
    2: const FlexColumnWidth(1.25),
    3: const FlexColumnWidth(3.75),
    4: const FlexColumnWidth(0.9375),
    5: const FlexColumnWidth(0.9375),
  };
  Map<int, TableColumnWidth>? columnWidths2 = <int, TableColumnWidth>{
    0: const FlexColumnWidth(8.125),
    1: const FlexColumnWidth(0.9375),
    2: const FlexColumnWidth(0.9375),
  };
  var companyPhone, companyAddress, companyPostCode;
  List amount = [];
  List detail = [];
  final Document pdf = Document();
  double totalNet = 0;
  double totalVat = 0;
  double delivNet = 0;
  double delivVat = 0;
  delivNet = double.parse(saleI[0]['deliveryPrice']);
  delivVat = double.parse((delivNet * 0.20).toStringAsFixed(2));
  List prices = [];
  for (int i = 0; i < productI.length; i++) {
    try {
      prices.add("${productI[i]['price']}");
    } catch (e) {
      prices.add(productI[i]['price']);
    }
  }
  for (int i = 0; i < productI.length; i++) {
    totalNet = totalNet + double.parse(prices[i]);
  }
  for (int i = 0; i < productI.length; i++) {
    double vat =
        double.parse(((double.parse(prices[i])) * 0.20).toStringAsFixed(2));
    totalVat = double.parse((totalVat + vat).toStringAsFixed(2));
  }
  totalNet = totalNet + delivNet;
  totalVat = totalVat + delivVat;
  //double vat = int.parse(price) * 0.20;
  String pdfName = saleID;
  companyAddress = customerI[0]['companyAddress'];
  companyPhone = customerI[0]['companyPhone'];
  companyPostCode = customerI[0]['postCode'];

  for (int i = 0; i < productI.length; i++) {
    if (productI[i]['type'] == 'single') {
      amount.add("${productI[i]['piece']}");
    } else if (productI[i]['type'] == 'set') {
      amount.add("${productI[i]['piece']}");
    } else {
      amount.add(
          "Box: ${productI[i]['boxAmount']} Lid: ${productI[i]['lidAmount']}");
    }
  }
  for (int i = 0; i < productI.length; i++) {
    if (productI[i]['type'] == 'single') {
      detail.add(
          "Color: ${productI[i]['productColor']}(${productI[i]['productColorPrice']})");
    } else if (productI[i]['type'] == 'set') {
      detail.add(
          "Selected Contents: ${productI[i]['selectedContent']} \n Napkin Color: ${productI[i]['napkinColor']}(${productI[i]['napkinColorPrice']}) \n Wetwipes Color: ${productI[i]['wetwipesColor']}(${productI[i]['wetwipesColorPrice']})");
    } else {
      detail.add(
          "Box is Printed?: ${productI[i]['boxIsPrinted']}(${productI[i]['boxPrintPrice']}) \n Lid is Printed?: ${productI[i]['lidIsPrinted']}(${productI[i]['lidPrintPrice']}) ");
    }
  }
  print(customerI + productI);

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a3,
      build: (context) => Column(
        children: [
          divider(500),
          spaceDivider(5),
          Text(
            'Proforma',
            style: const TextStyle(fontSize: 40, color: PdfColors.grey),
          ),
          spaceDivider(5),
          divider(500),
          spaceDivider(60),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Text(
                  "Mimbay Packaging Limited",
                  //textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "Unit 7, Tomo Industrial Estate \nUxbridge, London UB8 2JP, UK \nVAT No: GB289 1885 39 \nmimbaypackaging@gmail.com",
                  //textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Container(
              width: 165,
              height: 65,
              child: pw.Image(image),
            ),
          ]),
          spaceDivider(30),
          Row(children: [
            Container(
                width: 400,
                height: 120,
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: Column(children: [
                  SizedBox(height: 10),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Customer Name:   ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(customerName, style: TextStyle(fontSize: 14))
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Address:   ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(companyAddress, style: TextStyle(fontSize: 14))
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Post Code:   ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(companyPostCode, style: TextStyle(fontSize: 14))
                  ]),
                ])),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 300,
              height: 120,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Proforma Date:   ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(
                        "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}",
                        style: TextStyle(fontSize: 14))
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Invoice Nr:   ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text("tbc", style: TextStyle(fontSize: 14))
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Your Reference:   ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(customerI[0]['customerRef'],
                        style: TextStyle(fontSize: 14))
                  ]),
                ],
              ),
            ),
          ]),
          /* textRow(["Mimbay", customerName], textStyle1()),
          textRow([
            "England",
            "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}"
          ], textStyle2()),
          textRow(["", companyAddress], textStyle2()),
          textRow(["", customerName], textStyle2()),
          textRow(["", "Adres"], textStyle2()),*/
          spaceDivider(30),
          Column(children: [
            Container(
              color: PdfColors.white,
              child: Table(
                columnWidths: columnWidths,
                border: TableBorder.all(color: PdfColors.black),
                children: [
                  tableRow([
                    "No.",
                    "Product Name",
                    "Amount",
                    "Product Detail",
                    "Nett",
                    "VAT"
                  ], textStyle1()),
                  for (int i = 0; i < productI.length; i++)
                    tableRow([
                      "${i + 1}",
                      "${productI[i]['productName']}",
                      "${amount[i]}",
                      "${detail[i]}",
                      "${productI[i]['price']}",
                      "${(double.parse("${productI[i]['price']}") * 0.20).toStringAsFixed(2)}"
                    ], textStyle2()),
                ],
              ),
            ),
            Container(
                child: Table(
                    columnWidths: columnWidths2,
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                  tableRow(["Standart Delivery", "$delivNet", "$delivVat"],
                      textStyle1())
                ])),
            Container(
                child: Table(
                    columnWidths: columnWidths2,
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                  tableRow(
                      ["Order Value", "$totalNet", "$totalVat"], textStyle1())
                ]))
          ]),
          spaceDivider(30),
          divider(500),
          spaceDivider(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    textRow(["Subtotal Ex Vat", "$totalNet"], textStyle1()),
                    textRow(["VAT 20%", "$totalVat"], textStyle1()),
                    divider(500),
                    textRow([
                      "Total Inc Vat",
                      "${(totalNet + totalVat).toStringAsFixed(2)}"
                    ], textStyle1()),
                    divider(500),
                  ],
                ),
              ),
            ],
          ),
          spaceDivider(40),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "50% payment on order, 50% payment 1 week before delivery. \nFinal quantity and weight varies around 10% less or more. The difference will be reflected to balance payment.  \nThe plate sealer will be left free of charge during the period of use and all its services are free of charge. \n1x delivery included for whole order. Part orders may be subject to delivery charges.",
                  //textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 14),
                ),
              ]),
          spaceDivider(20),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Name",
                      //textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      "Bank",
                      //textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Account No",
                      //textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Sort Code",
                      //textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Swift Code",
                      //textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      "IBAN No.",
                      //textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ": Mimbay Packaging Ltd",
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        ": Lloyds, Silver St Enfield ",
                        //textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        ": 1481 6862 ",
                        //textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        ": 30 99 86 ",
                        //textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        ": LOYD GB 21043 ",
                        //textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        ": GB39 LOYD 3099 8614 8168 62 ",
                        //textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ])
              ]),
          spaceDivider(30),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Mimbay Packaging Limited",
                  //textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "www.mimbay.com",
                  //textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 14),
                ),
              ])
        ],
      ),
    ),
  );
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }

  //final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '/storage/emulated/0/Download/Mimbay/$pdfName.pdf';
  final File file = File(path);
  await file.writeAsBytes((await pdf.save()));
  material.Navigator.of(context).push(
    material.MaterialPageRoute(
      builder: (_) => PdfViewer(path: path),
    ),
  );
}

Widget divider(double width) {
  return Container(
    height: 3,
    width: width,
    decoration: const BoxDecoration(
      color: PdfColors.grey,
    ),
  );
}

tableRow(List<String> attributes, TextStyle textStyle) {
  return TableRow(
    children: attributes
        .map(
          (e) => Text(
            "  " + e,
            style: textStyle,
          ),
        )
        .toList(),
  );
}

Widget textRow(List<String> titleList, TextStyle textStyle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: titleList
        .map(
          (e) => Text(
            e,
            style: textStyle,
          ),
        )
        .toList(),
  );
}

TextStyle textStyle1() {
  return TextStyle(
    color: PdfColors.grey800,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyle2() {
  return const TextStyle(
    color: PdfColors.grey,
    fontSize: 22,
  );
}

Widget spaceDivider(double height) {
  return SizedBox(height: height);
}
