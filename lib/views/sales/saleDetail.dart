import 'package:crm_app/services/customerService.dart';
import 'package:crm_app/services/saleService.dart';
import 'package:crm_app/views/sales/addProformSet.dart';
import 'package:crm_app/views/sales/addProformSingle.dart';
import 'package:flutter/material.dart';

import '../../pdf/pdf_file_proforma.dart';
import 'addRecentBox.dart';

class SaleDetailScreen extends StatefulWidget {
  const SaleDetailScreen(
      {Key? key,
      required this.saleID,
      required this.productType,
      required this.customerName})
      : super(key: key);
  final saleID, productType, customerName;
  @override
  State<SaleDetailScreen> createState() => _SaleDetailScreenState();
}

class _SaleDetailScreenState extends State<SaleDetailScreen> {
  var proformCount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Sale to ${widget.customerName}"),
        actions: [

          FutureBuilder<dynamic>(
            future: SaleService.getSaleDetail(widget.saleID),
            builder: (context,snapshot){
              if(snapshot.hasData){
                if(snapshot.data[0]['isChecked']==true){
                  return const InkWell(
                      child: Icon(Icons.check,color: Colors.green,),
                  );
                  
                }else{
                  return  InkWell(
                    child:const Icon(Icons.check,color: Colors.red,),
                    onTap: (){
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
                            SaleService.checkSale( widget.saleID);
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
            );
                }
              }else{return const Center(child: CircularProgressIndicator(),);}
            },
            
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
          )
        ],
      ),
      /*body: FutureBuilder<dynamic>(
        future: SaleService.getSaleDetail(widget.saleID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (widget.productType) {
              case 'single':
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.43,
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
                            //const SizedBox(height: 5,),
                            const Divider(height: 2, thickness: 2),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Product Name: ${snapshot.data[0]['productName']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Product Size : ${snapshot.data[0]['productSize'].substring(0, snapshot.data[0]['productSize'].indexOf(':'))}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Product Color : ${snapshot.data[0]['productColor']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15)),
                            snapshot.data[0]['productColor'] != 'none'
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'Product Color Price: ${snapshot.data[0]['productColorPrice']}',
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
                            snapshot.data[0]['deliveryPrice'] != ""
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Delivery Price : ${snapshot.data[0]['deliveryPrice']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Delivery Price : 0',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Sale Staff: ${snapshot.data[0]['salesStaff']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Piece : ${snapshot.data[0]['piece']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15)),

                            const SizedBox(
                              height: 10,
                            ),
                            Text('Price : ${snapshot.data[0]['price']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15)),
                            const SizedBox(
                              height: 10,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: const Icon(Icons.edit),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddProformScreenSingle(
                                                  saleID: widget.saleID,
                                                  productSize: snapshot.data[0]
                                                      ['productSize'],
                                                  productColor: snapshot.data[0]
                                                      ['productColor'],
                                                  productColorPrice:
                                                      snapshot.data[0]
                                                          ['productColorPrice'],
                                                  productPrice: snapshot.data[0]
                                                      ['price'],
                                                  productPiece: snapshot.data[0]
                                                      ['piece'],
                                                  customerName:
                                                      widget.customerName,
                                                  productName: snapshot.data[0]
                                                      ['productName'],
                                                  deliveryPrice: snapshot
                                                      .data[0]['deliveryPrice'],
                                                  salesStaff: snapshot.data[0]
                                                      ['salesStaff'],
                                                  proformCount: snapshot.data[0]
                                                      ['proformCount'],
                                                )));
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                FutureBuilder<dynamic>(
                                    future: CustomerService.getCustomerDetail(
                                        snapshot.data[0]['customerName']),
                                    builder: (context, snapshotsa) {
                                      if (snapshotsa.hasData) {
                                        return InkWell(
                                          child: const Icon(Icons.description),
                                          onTap: () {
                                            String detail =
                                                "Product Color: ${snapshot.data[0]['productColor']}";
                                            orderPdfView(
                                                context,
                                                snapshot.data[0]
                                                    ['customerName'],
                                                snapshot.data[0]['productName'],
                                                snapshot.data[0]['piece'],
                                                snapshot.data[0]['price'],
                                                detail,
                                                snapshotsa.data[0]
                                                    ['companyAddress'],
                                                snapshotsa.data[0]
                                                    ['companyPhone'],
                                                widget.saleID);
                                          },
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Recents'),
                    Expanded(
                      child: FutureBuilder<dynamic>(
                        future:
                            SaleService.getSaleRecents(widget.saleID),
                        builder: (context, snapshots) {
                          int proformC = 0;
                          if (snapshot.data.length != null) {
                            proformC = snapshot.data.length;
                          }
                          if (proformC != 0 && snapshots.hasData) {
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshots.data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Card(
                                    elevation: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(64, 75, 96, .9),
                                      ),
                                      child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                          leading: Container(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Colors.white24))),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/box.png"),
                                              )),
                                            ),
                                          ),
                                          title: Text(
                                            "${snapshots.data[index].id}",
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
                                              Text(
                                                  "${snapshots.data[index]["productName"]}",
                                                  style: const TextStyle(
                                                      color: Colors.white))
                                            ],
                                          ),
                                          trailing: const Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.white,
                                              size: 30.0)),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Column(
                              children: const [
                                SizedBox(
                                  height: 10,
                                ),
                                Text('This sale is not have proforms'),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              case 'set':
                return Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.50,
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
                            'Product Name: ${snapshot.data[0]['productName']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Selected Contents: ${snapshot.data[0]['selectedContent']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Napkin Color: ${snapshot.data[0]['napkinColor']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Napkin Color Price: ${snapshot.data[0]['napkinColorPrice']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Wetwipes Color: ${snapshot.data[0]['wetwipesColor']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Wetwipes Color Price: ${snapshot.data[0]['wetwipesColorPrice']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Delivery Price: ${snapshot.data[0]['deliveryPrice']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Amount: ${snapshot.data[0]['piece']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Price: ${snapshot.data[0]['price']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                child: const Icon(Icons.edit),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddProformSetScreen(
                                            saleID: widget.saleID,
                                            selectedContent: snapshot.data[0]
                                                ['selectedContent'],
                                            napkinColor: snapshot.data[0]
                                                ['napkinColor'],
                                            napkinColorPrice: snapshot.data[0]
                                                ['napkinColorPrice'],
                                            wetwipesColor: snapshot.data[0]
                                                ['wetwipesColor'],
                                            wetwipesColorPrice: snapshot.data[0]
                                                ['wetwipesColorPrice'],
                                            setPrice: snapshot.data[0]['price'],
                                            setAmount: snapshot.data[0]
                                                ['piece'],
                                            customerName: snapshot.data[0]
                                                ['customerName'],
                                            productName: snapshot.data[0]
                                                ['productName'],
                                            deliveryPrice: snapshot.data[0]
                                                ['deliveryPrice'],
                                            salesStaff: snapshot.data[0]
                                                ['salesStaff'],
                                            proformCount: snapshot.data[0]
                                                ['proformCount'],
                                          )));
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              FutureBuilder<dynamic>(
                                future: CustomerService.getCustomerDetail(
                                    snapshot.data[0]['customerName']),
                                builder: (context, snapshotss) {
                                  if (snapshotss.hasData) {
                                    return InkWell(
                                      child: const Icon(Icons.description),
                                      onTap: () {
                                        String productDetail =
                                            "Wetwipescolor: ${snapshot.data[0]['wetwipesColor']} , Napkin Color: ${snapshot.data[0]['napkinColor']}";
                                        orderPdfView(
                                            context,
                                            snapshot.data[0]['customerName'],
                                            snapshot.data[0]['productName'],
                                            snapshot.data[0]['piece'],
                                            snapshot.data[0]['price'],
                                            productDetail,
                                            snapshotss.data[0]
                                                ['companyAddress'],
                                            snapshotss.data[0]['companyPhone'],
                                            widget.saleID);
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text('Recents'),
                  Expanded(
                    child: FutureBuilder<dynamic>(
                      future: SaleService.getSaleRecents(widget.saleID),
                      builder: (context, snapshots) {
                        int proformC = 0;
                        if (snapshot.data.length != null) {
                          proformC = snapshot.data.length;
                        }
                        if (proformC != 0 && snapshots.hasData) {
                          proformCount = snapshot.data?.length ?? 1;
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshots.data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Card(
                                  elevation: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(64, 75, 96, .9),
                                    ),
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                        leading: Container(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
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
                                              image: AssetImage(
                                                  "assets/images/box.png"),
                                            )),
                                          ),
                                        ),
                                        title: Text(
                                          "${snapshots.data[index].id}",
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
                                            Text(
                                                "${snapshots.data[index]["productName"]}",
                                                style: const TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                        trailing: const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                            size: 30.0)),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Column(
                            children: const [
                              SizedBox(
                                height: 10,
                              ),
                              Text('This sale is not have proforms'),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ]);
              case 'box':
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.50,
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
                              'Product Name: ${snapshot.data[0]['productName']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Box Size: ${snapshot.data[0]['boxSize']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Lid Size: ${snapshot.data[0]['lidSize']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Box Amount: ${snapshot.data[0]['boxAmount']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Lid Amount: ${snapshot.data[0]['lidAmount']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            snapshot.data[0]['boxIsPrinted'] != 'no'
                                ? Column(
                                    children: [
                                      Text(
                                        'Box Print Price: ${snapshot.data[0]['boxPrintPrice']}',
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
                            snapshot.data[0]['lidIsPrinted'] != 'no'
                                ? Column(
                                    children: [
                                      Text(
                                        'Lid Print Price: ${snapshot.data[0]['lidPrintPrice']}',
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
                              'Delivery Price: ${snapshot.data[0]['deliveryPrice']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Last Price: ${snapshot.data[0]['lastPrice']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: const Icon(Icons.edit),
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => AddRecentBoxScreen(
                                            customerName: widget.customerName,
                                            productName: snapshot.data[0]
                                                ['productName'],
                                            saleID: widget.saleID,
                                            boxSize: snapshot.data[0]
                                                ['boxSize'],
                                            lidSize: snapshot.data[0]
                                                ['lidSize'],
                                            boxAmount: snapshot.data[0]
                                                ['boxAmount'],
                                            lidAmount: snapshot.data[0]
                                                ['lidAmount'],
                                            boxIsPrinted: snapshot.data[0]
                                                ['boxIsPrinted'],
                                            lidIsPrinted: snapshot.data[0]
                                                ['lidIsPrinted'],
                                            boxPrintPrice: snapshot.data[0]
                                                ['boxPrintPrice'],
                                            lidPrintPrice: snapshot.data[0]
                                                ['lidPrintPrice'],
                                            deliveryPrice: snapshot.data[0]
                                                ['deliveryPrice'],
                                            lastPrice: snapshot.data[0]
                                                ['lastPrice'],
                                            salesStaff: snapshot.data[0]['salesStaff'],
                                            proformCount: snapshot.data[0]['proformCount'])));
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                FutureBuilder<dynamic>(
                                  future: CustomerService.getCustomerDetail(
                                      snapshot.data[0]['customerName']),
                                  builder: (context, snapshots) {
                                    if (snapshots.hasData) {
                                      String customerAddress =
                                          snapshots.data[0]['companyAddress'];
                                      String companyPhone =
                                          snapshots.data[0]['companyPhone'];
                                      return InkWell(
                                        child: const Icon(Icons.description),
                                        onTap: () {
                                          String productDetail =
                                              "Box is printed: ${snapshot.data[0]['boxIsPrinted']} , Lid is Printed: ${snapshot.data[0]['lidIsPrinted']}";
                                          String amount =
                                              "Box amount: ${snapshot.data[0]['boxAmount']} , Lid Amount: ${snapshot.data[0]['lidAmount']}";
                                          orderPdfView(
                                              context,
                                              snapshot.data[0]['customerName'],
                                              snapshot.data[0]['productName'],
                                              amount,
                                              snapshot.data[0]['lastPrice'],
                                              productDetail,
                                              customerAddress,
                                              companyPhone,
                                              widget.saleID);
                                        },
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Text('Recents'),
                    Expanded(
                      child: FutureBuilder<dynamic>(
                        future: SaleService.getSaleRecents(widget.saleID),
                        builder: (context, snapshots) {
                          int proformC = 0;
                          if (snapshot.data.length != null) {
                            proformC = snapshot.data.length;
                          }
                          if (proformC != 0 && snapshots.hasData) {
                            proformCount = snapshot.data?.length ?? 1;
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshots.data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Card(
                                    elevation: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(64, 75, 96, .9),
                                      ),
                                      child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                          leading: Container(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Colors.white24))),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/box.png"),
                                              )),
                                            ),
                                          ),
                                          title: Text(
                                            "${snapshots.data[index].id}",
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
                                              Text(
                                                  "${snapshots.data[index]["productName"]}",
                                                  style: const TextStyle(
                                                      color: Colors.white))
                                            ],
                                          ),
                                          trailing: const Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.white,
                                              size: 30.0)),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Column(
                              children: const [
                                SizedBox(
                                  height: 10,
                                ),
                                Text('This sale is not have proforms'),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),*/
    );
  }
}
