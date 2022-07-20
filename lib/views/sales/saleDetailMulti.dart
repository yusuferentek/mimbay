import 'package:card_swiper/card_swiper.dart';
import 'package:crm_app/pdf/pdf_file_invoice.dart';
import 'package:crm_app/views/sales/addProduct/addPCategory.dart';
import 'package:crm_app/views/sales/deliveryUpdate.dart';
import 'package:crm_app/views/sales/recentDetail.dart';
import 'package:crm_app/views/sales/updateSaleSelectP.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

import '../../pdf/pdf_file_proforma.dart';
import '../../pdf/pdf_page.dart';
import '../../services/customerService.dart';
import '../../services/saleService.dart';
import 'addProformSingle.dart';

class SaleDetailMultiScreen extends StatefulWidget {
  const SaleDetailMultiScreen(
      {Key? key, required this.saleID, required this.customerName})
      : super(key: key);
  final saleID, customerName;
  @override
  State<SaleDetailMultiScreen> createState() => _SaleDetailMultiScreenState();
}

class _SaleDetailMultiScreenState extends State<SaleDetailMultiScreen> {
  var pdfDetailsProduct, pdfDetailsCustomer;
  var proformCount;
  TextEditingController _invoiceNumberCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Sale to ${widget.customerName}"),
        actions: [
          InkWell(
            child: Icon(Icons.refresh),
            onTap: () {
              setState(() {});
            },
          ),
          const SizedBox(
            width: 10,
          ),
          FutureBuilder<dynamic>(
            future: SaleService.getSaleProducts(widget.saleID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder<dynamic>(
                  future:
                      CustomerService.getCustomerDetail(widget.customerName),
                  builder: (context, snapshotCustomer) {
                    if (snapshotCustomer.hasData) {
                      return FutureBuilder<dynamic>(
                        future: SaleService.getSaleDetail(widget.saleID),
                        builder: (context, snapshotSale) {
                          if (snapshotSale.hasData) {
                            return snapshotSale.data[0]['isChecked'] == false
                                ? InkWell(
                                    child: const Icon(
                                      Icons.description,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                      orderPdfViewProform(
                                          context,
                                          snapshotCustomer.data,
                                          snapshot.data,
                                          snapshotSale.data[0]['saleID'],
                                          widget.customerName,
                                          snapshotSale.data);
                                    },
                                  )
                                : InkWell(
                                    child: const Icon(
                                      Icons.description,
                                      color: Colors.green,
                                    ),
                                    onTap: () {
                                      orderPdfViewInvoice(
                                          context,
                                          snapshotCustomer.data,
                                          snapshot.data,
                                          widget.saleID,
                                          widget.customerName,
                                          snapshotSale.data);
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
            child: Icon(Icons.add),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddPCategoryScreen(saleID: widget.saleID)));
            },
          ),
          const SizedBox(
            width: 10,
          ),
          FutureBuilder<dynamic>(
            future: SaleService.getSaleDetail(widget.saleID),
            builder: (context, snapshotss) {
              if (snapshotss.hasData) {
                return snapshotss.data[0]['isChecked'] == false
                    ? FutureBuilder<dynamic>(
                        future: SaleService.getSaleProducts(widget.saleID),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<String> pNames = [];
                            for (int i = 0; i < snapshot.data.length; i++) {
                              pNames.add(snapshot.data[i]['productName'] +
                                  ":" +
                                  snapshot.data[i]['type']);
                            }
                            return FutureBuilder<dynamic>(
                                future:
                                    SaleService.getSaleProducts(widget.saleID),
                                builder: (context, snapshotPD) {
                                  return FutureBuilder<dynamic>(
                                      future: SaleService.getSaleDetail(
                                          widget.saleID),
                                      builder: (context, snapshotSD) {
                                        if (snapshotSD.hasData) {
                                          return InkWell(
                                            child: const Icon(Icons.edit),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateSaleSelectProductScreen(
                                                            proformCount: snapshotss
                                                                    .data[0][
                                                                'proformCount'],
                                                            customerName: widget
                                                                .customerName,
                                                            saleID:
                                                                widget.saleID,
                                                            saleDetail:
                                                                snapshotSD.data,
                                                            products:
                                                                snapshotPD.data,
                                                          )));
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      });
                                  ;
                                });
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    : Container();
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
          FutureBuilder<dynamic>(
            future: SaleService.getSaleDetail(widget.saleID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data[0]['isChecked'] == true) {
                  return const InkWell(
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  );
                } else {
                  return InkWell(
                    child: const Icon(
                      Icons.check,
                      color: Colors.red,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Are you sure?'),
                              content: const Text(
                                  "Are you sure you want to check this sale?"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Yes!'),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Are you sure?'),
                                            content: const Text(
                                                "This action cannot be undone."),
                                            actions: <Widget>[
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    FutureBuilder<dynamic>(
                                                      future: SaleService
                                                          .getInvoiceNumber(),
                                                      builder: (context,
                                                          snapshotIn) {
                                                        if (snapshotIn
                                                            .hasData) {
                                                          return TextButton(
                                                            child: const Text(
                                                                'Ok'),
                                                            onPressed: () {
                                                              int inNr = snapshotIn.data+1; 
                                                              SaleService
                                                                  .checkSale(widget
                                                                      .saleID);
                                                              SaleService.enterInvoiceNumber(
                                                                  widget.saleID,
                                                                  inNr);
                                                                  SaleService.updateInvoiceNumber(inNr);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              setState(() {});
                                                            },
                                                          );
                                                        } else {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text('No'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        });
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
                  );
                }
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
                          "Are you sure you want to delete this sale?"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Yes!'),
                          onPressed: () {
                            SaleService.deleteSale(widget.saleID);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
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
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: SaleService.getSaleProducts(widget.saleID),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                int uzunluk = 0;
                if (snapshot.data.length != null) {
                  uzunluk = snapshot.data.length;
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Swiper(
                    pagination: SwiperPagination(),
                    control: SwiperControl(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      switch (snapshot.data[index]['type']) {
                        case 'single':
                          return Container(
                            //width: MediaQuery.of(context).size.width,
                            //height: MediaQuery.of(context).size.height * 0.40,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(58, 66, 86, 1.0),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Divider(height: 2, thickness: 2),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Product Name: ${snapshot.data[index]['productName']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Product Size : ${snapshot.data[index]['productSize'].substring(0, snapshot.data[index]['productSize'].indexOf(':'))}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Product Unit Price : ${snapshot.data[index]['productSize'].substring(snapshot.data[index]['productSize'].indexOf(':') + 1)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Product Color : ${snapshot.data[index]['productColor']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15)),
                                  snapshot.data[index]['productColor'] != 'none'
                                      ? Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                'Product Color Price: ${snapshot.data[index]['productColorPrice']}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15)),
                                          ],
                                        )
                                      : Column(
                                          children: const [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('Product Color Price: 0',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Piece : ${snapshot.data[index]['piece']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Default Price : ${snapshot.data[index]['defaultPrice']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Last Price : ${snapshot.data[index]['price']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        case 'set':
                          return Container(
                            //width: MediaQuery.of(context).size.width,
                            //height: MediaQuery.of(context).size.height * 0.50,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(58, 66, 86, 1.0),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Divider(height: 2, thickness: 2),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Product Name: ${snapshot.data[index]['productName']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      'Selected Contents: ${snapshot.data[index]['selectedContent']}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Napkin Color: ${snapshot.data[index]['napkinColor']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Napkin Color Price: ${snapshot.data[index]['napkinColorPrice']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Wetwipes Color: ${snapshot.data[index]['wetwipesColor']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Wetwipes Color Price: ${snapshot.data[index]['wetwipesColorPrice']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Amount: ${snapshot.data[index]['piece']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Last Price: ${snapshot.data[index]['price']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        case 'box':
                          return SingleChildScrollView(
                            child: Container(
                              //width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height * 0.50,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(58, 66, 86, 1.0),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Divider(height: 2, thickness: 2),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      'Product Name: ${snapshot.data[index]['productName']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Box Size: ${snapshot.data[index]['boxSize'].substring(0, snapshot.data[index]['boxSize'].indexOf(':'))}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Box Unit Price: ${snapshot.data[index]['boxSize'].substring(snapshot.data[index]['boxSize'].indexOf(':') + 1)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Lid Size: ${snapshot.data[index]['lidSize'].substring(0, snapshot.data[index]['lidSize'].indexOf(':'))}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Lid Unit Price: ${snapshot.data[index]['lidSize'].substring(snapshot.data[index]['lidSize'].indexOf(':') + 1)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Box Amount: ${snapshot.data[index]['boxAmount']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Lid Amount: ${snapshot.data[index]['lidAmount']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    snapshot.data[index]['boxIsPrinted'] != 'no'
                                        ? Column(
                                            children: [
                                              Text(
                                                'Box Print Price: ${snapshot.data[index]['boxPrintPrice']}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: const [
                                              Text(
                                                'Box is not printed',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                    snapshot.data[index]['lidIsPrinted'] != 'no'
                                        ? Column(
                                            children: [
                                              Text(
                                                'Lid Print Price: ${snapshot.data[index]['lidPrintPrice']}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: const [
                                              Text(
                                                'Lid is not printed',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                    Text(
                                      'Default Price: ${snapshot.data[index]['defaultPrice']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Last Price: ${snapshot.data[index]['price']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        default:
                          return Container();
                      }
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<dynamic>(
            future: SaleService.getSaleDetail(widget.saleID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(58, 66, 86, 1.0),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        snapshot.data[0]['isChecked'] == false
                            ? InkWell(
                                child: Icon(Icons.local_shipping),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DeliveryUpdateScreen(
                                              saleID: widget.saleID,
                                              deliveryPrice: snapshot.data[0]
                                                  ['deliveryPrice'])));
                                },
                              )
                            : const Icon(
                                Icons.local_shipping,
                                color: Colors.grey,
                              ),
                        Text(
                            "Delivery Price: ${snapshot.data[0]['deliveryPrice']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                        Text("Sales Staff: ${snapshot.data[0]['salesStaff']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                      ]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Recents',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: SaleService.getSaleRecents(widget.saleID),
              builder: (context, snapshots) {
                int proLe = snapshots.data?.length ?? 0;
                if (proLe != 0 && snapshots.hasData) {
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: proLe,
                    itemBuilder: (context, index) {
                      return FutureBuilder<dynamic>(
                          future: CustomerService.getCustomerDetail(
                              widget.customerName),
                          builder: (context, snapshotCustomer) {
                            if (snapshotCustomer.hasData) {
                              return FutureBuilder<dynamic>(
                                  future: SaleService.getSaleProformProducts(
                                      widget.saleID, snapshots.data[index].id),
                                  builder: (context, snapshotProducts) {
                                    if (snapshotCustomer.hasData) {
                                      return FutureBuilder<dynamic>(
                                          future: SaleService.getProformDetail(
                                              widget.saleID,
                                              snapshots.data[index].id),
                                          builder:
                                              (context, snapshotProformDetail) {
                                            return InkWell(
                                                child: Card(
                                                  elevation: 8.0,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          64, 75, 96, .9),
                                                    ),
                                                    child: ListTile(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20,
                                                                vertical: 10),
                                                        leading: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 12.0),
                                                          decoration: const BoxDecoration(
                                                              border: Border(
                                                                  right: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .white24))),
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/box.png"),
                                                            )),
                                                          ),
                                                        ),
                                                        title: Text(
                                                          "${snapshots.data[index].id}",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                                        subtitle: Row(
                                                          children: const [
                                                            Icon(
                                                              Icons.widgets,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text("",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white))
                                                          ],
                                                        ),
                                                        trailing: const Icon(
                                                            Icons
                                                                .keyboard_arrow_right,
                                                            color: Colors.white,
                                                            size: 30.0)),
                                                  ),
                                                ),
                                                onTap: () {
                                                  orderPdfViewProform(
                                                      context,
                                                      snapshotCustomer.data,
                                                      snapshotProducts.data,
                                                      snapshotProformDetail
                                                          .data[0]['saleID'],
                                                      widget.customerName,
                                                      snapshotProformDetail
                                                          .data);
                                                });
                                          });
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
                          });
                    },
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: 250,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Text('This sale has no offer history',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)))),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
