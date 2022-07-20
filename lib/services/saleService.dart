import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart';

class SaleService {
  static Future<List>? getSingleColor(String? Singleproduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('singleProducts')
        .collection('products')
        .doc(Singleproduct)
        .get();

    String colors = await response.data()['color'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future<List>? getSetNapkinColor(String? setProduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('setProducts')
        .collection('sets')
        .doc(setProduct)
        .get();

    String colors = await response.data()['napkinColor'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future<List>? getBoxSize(String? productName) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('boxProducts')
        .collection('boxes')
        .doc(productName)
        .get();

    String colors = await response.data()['boxSize'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future<List>? getLidSize(String? productName) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('boxProducts')
        .collection('boxes')
        .doc(productName)
        .get();

    String colors = await response.data()['lidSize'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future<List>? getSetWetWipesColor(String? setProduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('setProducts')
        .collection('sets')
        .doc(setProduct)
        .get();

    String colors = await response.data()['wetwipesColor'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future<List>? getSingleColorPrice(String? Singleproduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('singleProducts')
        .collection('products')
        .doc(Singleproduct)
        .get();

    String colors = await response.data()['colorPrice'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future<List>? getSetNapkinColorPrice(String? SetProduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('setProducts')
        .collection('sets')
        .doc(SetProduct)
        .get();

    String colors = await response.data()['napkinColorPrice'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future<List>? getSetWetwipesColorPrice(String? SetProduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('setProducts')
        .collection('sets')
        .doc(SetProduct)
        .get();

    String colors = await response.data()['wetwipesColorPrice'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future<String>? getSingleStock(String? Singleproduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('singleProducts')
        .collection('products')
        .doc(Singleproduct)
        .get();

    String stock = await response.data()['stock'].toString();

    return stock;
  }

  static Future<String>? getSetStock(String? SetProduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('setProducts')
        .collection('sets')
        .doc(SetProduct)
        .get();

    String stock = await response.data()['setStock'].toString();

    return stock;
  }

  static Future<String>? getBoxStock(String? BoxProduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('boxProducts')
        .collection('boxes')
        .doc(BoxProduct)
        .get();

    String Boxstock = await response.data()['boxStock'].toString();
    String LidStock = await response.data()['lidStock'].toString();
    String stock = 'Box Stock: $Boxstock  Lid Stock: $LidStock';
    return stock;
  }

  static Future<String>? getBoxSizePrice(String? BoxProduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('boxProducts')
        .collection('boxes')
        .doc(BoxProduct)
        .get();

    String boxPrice = await response.data()['boxSize'].toString();

    return boxPrice;
  }

  static Future<String>? getLidSizePrice(String? BoxProduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('boxProducts')
        .collection('boxes')
        .doc(BoxProduct)
        .get();

    String lidPrice = await response.data()['lidSize'].toString();

    return lidPrice;
  }

  static Future<List>? getSetSelectedContents(saleID, pID) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    response = await userRef.doc(saleID).collection('products').doc(pID).get();

    var selectedContents = await response.data()['selectedContent'];

    return selectedContents;
  }

  static Future<List>? getSingleSize(String? Singleproduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('singleProducts')
        .collection('products')
        .doc(Singleproduct)
        .get();

    String colors = await response.data()['size'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future createSingleSale(
      defaultPrice,
      customerName,
      deliveryPrice,
      salesStaff,
      productColor,
      productColorPrice,
      productName,
      productSize,
      price,
      piece) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var docID;
    String saleID =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}_$customerName';
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.add({
      'saleID': saleID,
      'customerName': customerName,
      'deliveryPrice': deliveryPrice,
      'salesStaff': salesStaff,
      'proformCount': 0,
      'isChecked': false,
    }).then((value) {
      docID = value.id.toString();
    });
    addSingleSaleProducts(defaultPrice, docID, productColor, productColorPrice,
        productName, productSize, price, piece);
  }

  static Future addSingleSaleProducts(defaultPrice, saleID, productColor,
      productColorPrice, productName, productSize, price, piece) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.doc(saleID).collection('products').doc().set({
      'productColor': productColor,
      'productColorPrice': productColorPrice,
      'productName': productName,
      'productSize': productSize,
      'price': price,
      'piece': piece,
      'defaultPrice': defaultPrice,
      'type': 'single',
    });
  }

  static Future newSingleSaleProduct(defaultPrice, saleID, productColor,
      productColorPrice, productName, productSize, price, piece) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.doc(saleID).collection('products').add({
      'productColor': productColor,
      'productColorPrice': productColorPrice,
      'productName': productName,
      'productSize': productSize,
      'price': price,
      'piece': piece,
      'defaultPrice': defaultPrice,
      'type': 'single',
    });
  }

  static Future createBoxSale(
    defaultPrice,
    customerName,
    productName,
    boxAmount,
    lidAmount,
    boxSize,
    lidSize,
    boxIsPrinted,
    lidIsPrinted,
    boxPrintPrice,
    lidPrintPrice,
    deliveryPrice,
    lastPrice,
    salesStaff,
  ) async {
    var docID;
    String saleID =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}_$customerName';
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.add({
      'saleID': saleID,
      'customerName': customerName,
      'deliveryPrice': deliveryPrice,
      'salesStaff': salesStaff,
      'proformCount': 0,
      'isChecked': false,
    }).then((value) {
      docID = value.id.toString();
    });
    addBoxSaleProduct(
        defaultPrice,
        docID,
        productName,
        boxAmount,
        lidAmount,
        boxSize,
        lidSize,
        boxIsPrinted,
        lidIsPrinted,
        boxPrintPrice,
        lidPrintPrice,
        lastPrice);
  }

  static Future addBoxSaleProduct(
    defaultPrice,
    saleID,
    productName,
    boxAmount,
    lidAmount,
    boxSize,
    lidSize,
    boxIsPrinted,
    lidIsPrinted,
    boxPrintPrice,
    lidPrintPrice,
    lastPrice,
  ) async {
    if (boxIsPrinted == true) {
      boxIsPrinted = 'yes';
    } else {
      boxIsPrinted = 'no';
    }
    if (lidIsPrinted == true) {
      lidIsPrinted = 'yes';
    } else {
      lidIsPrinted = 'no';
    }
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.doc(saleID).collection('products').doc().set({
      'productName': productName,
      'boxAmount': boxAmount,
      'lidAmount': lidAmount,
      'boxSize': boxSize,
      'lidSize': lidSize,
      'boxIsPrinted': boxIsPrinted,
      'lidIsPrinted': lidIsPrinted,
      'boxPrintPrice': boxPrintPrice,
      'lidPrintPrice': lidPrintPrice,
      'price': lastPrice,
      'defaultPrice': defaultPrice,
      'type': 'box'
    });
  }

  static Future NewBoxSaleProduct(
    defaultPrice,
    saleID,
    productName,
    boxAmount,
    lidAmount,
    boxSize,
    lidSize,
    boxIsPrinted,
    lidIsPrinted,
    boxPrintPrice,
    lidPrintPrice,
    lastPrice,
  ) async {
    if (boxIsPrinted == true) {
      boxIsPrinted = 'yes';
    } else {
      boxIsPrinted = 'no';
    }
    if (lidIsPrinted == true) {
      lidIsPrinted = 'yes';
    } else {
      lidIsPrinted = 'no';
    }
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.doc(saleID).collection('products').add({
      'productName': productName,
      'boxAmount': boxAmount,
      'lidAmount': lidAmount,
      'boxSize': boxSize,
      'lidSize': lidSize,
      'boxIsPrinted': boxIsPrinted,
      'lidIsPrinted': lidIsPrinted,
      'boxPrintPrice': boxPrintPrice,
      'lidPrintPrice': lidPrintPrice,
      'price': lastPrice,
      'defaultPrice': defaultPrice,
      'type': 'box'
    });
  }

  static Future createSingleSaleProform(saleID, productColor, productColorPrice,
      productName, productSize, price, piece, proformCount) async {
    int proco = proformCount + 1;
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    userRef.doc(saleID).collection('proforms').doc("Recent-$proco").set({
      'saleID': saleID,
      'productColor': productColor,
      'productColorPrice': productColorPrice,
      'productName': productName,
      'productSize': productSize,
      'price': price,
      'piece': piece,
      'proformCount': proco,
      'type': 'single'
    });
  }

  static Future createSetSaleProform(
      saleID,
      napkinColor,
      napkinColorPrice,
      wetwipesColor,
      wetwipesColorPrice,
      productName,
      selectedContent,
      price,
      piece,
      proformCount) async {
    var response;
    int proco = proformCount + 1;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    userRef.doc(saleID).collection('proforms').doc('Recent-${proco}').set({
      'napkinColor': napkinColor,
      'wetwipesColor': wetwipesColor,
      'napkinColorPrice': napkinColorPrice,
      'wetwipesColorPrice': wetwipesColorPrice,
      'productName': productName,
      'selectedContent': selectedContent,
      'price': price,
      'piece': piece,
      'type': 'set',
      'proformCount': proco,
    });
  }

  static Future createBoxSaleRecent(
      saleID,
      productName,
      boxSize,
      lidSize,
      boxAmount,
      lidAmount,
      boxIsPrinted,
      lidIsPrinted,
      boxPrintPrice,
      lidPrintPrice,
      lastPrice,
      proformCount) async {
    var response;
    int proco = proformCount + 1;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    userRef.doc(saleID).collection('proforms').doc('Recent-$proco').set({
      'productName': productName,
      'boxSize': boxSize,
      'lidSize': lidSize,
      'boxAmount': boxAmount,
      'lidAmount': lidAmount,
      'boxIsPrinted': boxIsPrinted,
      'lidIsPrinted': lidIsPrinted,
      'boxPrintPrice': boxPrintPrice,
      'lidPrintPrice': lidPrintPrice,
      'price': lastPrice,
      'type': 'box',
      'proformCount': proco,
    });
  }

  static Future updateSingleSale(productColor, productColorPrice, productSize,
      price, piece, saleID, proformCount, pID) async {
    var response;
    int proco = proformCount + 1;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    userRef.doc(saleID).collection('products').doc(pID).update({
      'productColor': productColor,
      'productColorPrice': productColorPrice,
      'productSize': productSize,
      'price': price,
      'piece': piece,
    });
    userRef.doc(saleID).update({'proformCount': proco});
  }

  static Future enterInvoiceNumber(saleID, invoiceNumber) async {
    var response;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    userRef.doc(saleID).update({'invoiceNumber': invoiceNumber});
  }

  static Future updateDeliveryPrice(saleID, newPrice) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.doc(saleID).update({
      'deliveryPrice': newPrice,
    });
  }

  static Future transferSale(saleID, saleDetail, products) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef
        .doc(saleID)
        .collection('proforms')
        .doc("recent-${saleDetail[0]['proformCount'] + 1}")
        .set({
      'customerName': saleDetail[0]['customerName'],
      'deliveryPrice': saleDetail[0]['deliveryPrice'],
      'isChecked': false,
      'saleID': saleDetail[0]['saleID'],
      'invoiceNumber': saleDetail[0]['invoiceNumber'],
      'salesStaff': saleDetail[0]['salesStaff'],
    });
    for (int i = 0; i < products.length; i++) {
      if (products[i]['type'] == 'single') {
        await userRef
            .doc(saleID)
            .collection('proforms')
            .doc("recent-${saleDetail[0]['proformCount'] + 1}")
            .collection('products')
            .add({
          'defaultPrice': products[i]['defaultPrice'],
          'piece': products[i]['piece'],
          'price': products[i]['price'],
          'productColor': products[i]['productColor'],
          'productColorPrice': products[i]['productColorPrice'],
          'productName': products[i]['productName'],
          'productSize': products[i]['productSize'],
          'type': products[i]['type'],
        });
      }
      if (products[i]['type'] == 'set') {
        await userRef
            .doc(saleID)
            .collection('proforms')
            .doc("recent-${saleDetail[0]['proformCount'] + 1}")
            .collection('products')
            .add({
          'napkinColor': products[i]['napkinColor'],
          'napkinColorPrice': products[i]['napkinColorPrice'],
          'price': products[i]['price'],
          'productName': products[i]['productName'],
          'selectedContent': products[i]['selectedContent'],
          'piece': products[i]['piece'],
          'wetwipesColor': products[i]['wetwipesColor'],
          'wetwipesColorPrice': products[i]['wetwipesColorPrice'],
          'type': 'set'
        });
      }
      if (products[i]['type'] == 'box') {
        await userRef
            .doc(saleID)
            .collection('proforms')
            .doc("recent-${saleDetail[0]['proformCount'] + 1}")
            .collection('products')
            .add({
          'productName': products[i]['productName'],
          'boxAmount': products[i]['boxAmount'],
          'lidAmount': products[i]['lidAmount'],
          'boxSize': products[i]['boxSize'],
          'lidSize': products[i]['lidSize'],
          'boxIsPrinted': products[i]['boxIsPrinted'],
          'lidIsPrinted': products[i]['lidIsPrinted'],
          'boxPrintPrice': products[i]['boxPrintPrice'],
          'lidPrintPrice': products[i]['lidPrintPrice'],
          'price': products[i]['price'],
          'defaultPrice': products[i]['defaultPrice'],
          'type': 'box'
        });
      }
    }
  }

  static Future updateSetSale(
      saleID,
      pID,
      selectedContent,
      napkinColor,
      napkinColorPrice,
      wetwipesColorPrice,
      wetwipesColor,
      amount,
      price,
      proformCount) async {
    int proco = proformCount + 1;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final userRef = _firestore.collection('sales');
    userRef.doc(saleID).collection('products').doc(pID).update({
      'selectedContent': selectedContent,
      'napkinColor': napkinColor,
      'napkinColorPrice': napkinColorPrice,
      'wetwipesColor': wetwipesColor,
      'wetwipesColorPrice': wetwipesColorPrice,
      'piece': amount,
      'price': price,
      'proformCount': proco
    });
    userRef.doc(saleID).update({'proformCount': proco});
  }

  static Future updateBoxSale(
      saleID,
      pID,
      boxSize,
      lidSize,
      boxAmount,
      lidAmount,
      boxIsPrinted,
      lidIsPrinted,
      boxPrintPrice,
      lidPrintPrice,
      lastPrice,
      proformCount) async {
    int proco = proformCount + 1;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final userRef = _firestore.collection('sales');
    userRef.doc(saleID).collection('products').doc(pID).update({
      'boxSize': boxSize,
      'lidSize': lidSize,
      'boxAmount': boxAmount,
      'lidAmount': lidAmount,
      'boxIsPrinted': boxIsPrinted,
      'lidIsPrinted': lidIsPrinted,
      'boxPrintPrice': boxPrintPrice,
      'lidPrintPrice': lidPrintPrice,
      'price': lastPrice,
      'proformCount': proco
    });
    userRef.doc(saleID).update({'proformCount': proco});
  }

  static Future newSetSaleProduct(
    saleID,
    productName,
    setContent,
    napkinColor,
    napkinColorPrice,
    wetwipesColor,
    wetwipesColorPrice,
    price,
    piece,
  ) async {
    var response;
    var docID;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.doc(saleID).collection('products').add({
      'napkinColor': napkinColor,
      'napkinColorPrice': napkinColorPrice,
      'price': price,
      'productName': productName,
      'selectedContent': setContent,
      'piece': piece,
      'wetwipesColor': wetwipesColor,
      'wetwipesColorPrice': wetwipesColorPrice,
      'type': 'set'
    });
  }

  static Future createSetSale(
      defaultPrice,
      salesStaff,
      customerName,
      productName,
      setContent,
      napkinColor,
      napkinColorPrice,
      wetwipesColor,
      wetwipesColorPrice,
      price,
      piece,
      deliveryPrice) async {
    var response;
    var docID;
    String saleID =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}_$customerName';
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.add({
      'saleID': saleID,
      'customerName': customerName,
      'salesStaff': salesStaff,
      'deliveryPrice': deliveryPrice,
      'proformCount': 0,
      'isChecked': false,
    }).then((value) {
      docID = value.id.toString();
    });
    addSetSaleProduct(defaultPrice, docID, productName, setContent, napkinColor,
        napkinColorPrice, wetwipesColor, wetwipesColorPrice, price, piece);
  }

  static Future addSetSaleProduct(
    defaultPrice,
    saleID,
    productName,
    setContent,
    napkinColor,
    napkinColorPrice,
    wetwipesColor,
    wetwipesColorPrice,
    price,
    piece,
  ) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('sales');
    await userRef.doc(saleID).collection('products').doc().set({
      'napkinColor': napkinColor,
      'napkinColorPrice': napkinColorPrice,
      'price': price,
      'productName': productName,
      'selectedContent': setContent,
      'piece': piece,
      'wetwipesColor': wetwipesColor,
      'wetwipesColorPrice': wetwipesColorPrice,
      'defaultPrice': defaultPrice,
      'type': 'set'
    });
  }

  static Future<List>? getSetContent(String? setProduct) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('categories');
    response = await userRef
        .doc('setProducts')
        .collection('sets')
        .doc(setProduct)
        .get();

    String colors = await response.data()['setContent'];
    List<String> out = colors.split(',');

    return out;
  }

  static Future<List> getSaleRecents(saleID) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('sales');

    response = await _mainCollection.doc(saleID).collection('proforms').get();

    final data = await response.docs;
    return data;
  }

  static Future<List> getAllSale() async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('sales');

    response = await _mainCollection.get();
    final data = response.docs;
    // final data = response.docs.map((doc) => doc.data()).toList();
    return data;
  }

  static Future<List> getSaleProducts(saleID) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('sales');
    response = await _mainCollection.doc(saleID).collection('products').get();
    var datas = await response.docs;
    return datas;
  }

  static Future<List> getSaleProformProducts(saleID, proformID) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('sales');
    response = await _mainCollection
        .doc(saleID)
        .collection('proforms')
        .doc(proformID)
        .collection('products')
        .get();
    var datas = await response.docs;
    return datas;
  }

  static Future<List> getRecentProducts(saleID, recentID) async {
    var response;
    List datass = [];
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('sales');
    response = await _mainCollection
        .doc(saleID)
        .collection('proforms')
        .doc(recentID)
        .get();
    var datas = await response.data();
    datass.add(datas);
    return datass;
  }

  static Future<List> getSaleDetail(saleID) async {
    List data = [];
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('sales');

    response = await _mainCollection.doc(saleID).get();
    var datas = await response.data();

    data.add(datas);
    return data;
  }

  static Future<List> getProformDetail(saleID, proformID) async {
    List data = [];
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('sales');

    response = await _mainCollection
        .doc(saleID)
        .collection('proforms')
        .doc(proformID)
        .get();
    var datas = await response.data();

    data.add(datas);
    return data;
  }

  static Future checkSale(saleID) async {
    var response;
    var collection = FirebaseFirestore.instance.collection('sales');
    collection.doc(saleID).update({'isChecked': true, 'date': DateTime.now()});
    var collectionSP = FirebaseFirestore.instance
        .collection('sales')
        .doc(saleID)
        .collection('products');
    response = await collectionSP.get();
    var salePDocs = await response.docs;
    var collectionP = FirebaseFirestore.instance.collection('categories');
    List pName = [];

    for (int i = 0; i < salePDocs.length; i++) {
      pName.add(salePDocs[i]['productName']);
      if (salePDocs[i]['type'] == 'single') {
        var pAmount = salePDocs[i]['piece'].toString();
        var respP = await collectionP
            .doc('singleProducts')
            .collection('products')
            .doc(pName[i])
            .get();
        var amount = respP.data()!['stock'].toString();
        int newAmount = int.parse(amount) - int.parse(pAmount);
        String sAmount = newAmount.toString();

        collectionP
            .doc('singleProducts')
            .collection('products')
            .doc(pName[i])
            .update({'stock': sAmount});
      } else if (salePDocs[i]['type'] == 'set') {
        var pAmountSet = salePDocs[i]['piece'].toString();
        var respP = await collectionP
            .doc('setProducts')
            .collection('sets')
            .doc(pName[i])
            .get();
        var amount = respP.data()!['setStock'].toString();
        int newAmount = int.parse(amount) - int.parse(pAmountSet);
        String sAmount = newAmount.toString();
        collectionP
            .doc('setProducts')
            .collection('sets')
            .doc(pName[i])
            .update({'setStock': sAmount});
      } else if (salePDocs[i]['type'] == 'box') {
        var pAmountBox = salePDocs[i]['boxAmount'].toString();
        var pAmountLid = salePDocs[i]['lidAmount'].toString();
        var respP = await collectionP
            .doc('boxProducts')
            .collection('boxes')
            .doc(pName[i])
            .get();
        var boxAmount = respP.data()!['boxStock'].toString();
        var lidAmount = respP.data()!['lidStock'].toString();
        int newBoxAmount = int.parse(boxAmount) - int.parse(pAmountBox);
        int newlidAmount = int.parse(lidAmount) - int.parse(pAmountLid);
        String liddAmount = newlidAmount.toString();
        String boxxAmount = newBoxAmount.toString();
        collectionP
            .doc('boxProducts')
            .collection('boxes')
            .doc(pName[i])
            .update({
          'boxStock': boxxAmount,
          'lidStock': liddAmount,
        });
      }
    }
  }

  static Future deleteSale(saleID) async {
    var collection = FirebaseFirestore.instance.collection('sales');
    await collection.doc(saleID).delete();
  }

  static Future deleteSaleProduct(saleID, pID) async {
    var collection = FirebaseFirestore.instance.collection('sales');
    await collection.doc(saleID).collection('products').doc(pID).delete();
  }

  static Future<List> getSelectedDateSalesProducts(startDate, endDate) async {
    var collectionSale = FirebaseFirestore.instance.collection('sales');
    var responseSale = await collectionSale.get();
    var responseProducts;
    var dataSale = responseSale.docs;
    List filteredProducts = [];

    for (int i = 0; i < dataSale.length; i++) {
      if (dataSale[i]['isChecked'] == true) {
        DateTime singleD =
            DateTime.parse(dataSale[i]['date'].toDate().toString());
        if (singleD.compareTo(endDate) <= 0 &&
            singleD.compareTo(startDate) >= 0) {
          responseProducts = await collectionSale
              .doc(dataSale[i].id)
              .collection('products')
              .get();
          var dataProducts = responseProducts.docs;

          filteredProducts.add(dataProducts);
        }
      }
    }
    //--------------------------------
    List ints3 = filteredProducts.fold([], (prev, curr) => prev + curr);
    return ints3;
  }

  static Future<List> getSelectedDateSalesSales(startDate, endDate) async {
    var collectionSale = FirebaseFirestore.instance.collection('sales');
    var responseSale = await collectionSale.get();
    var responseProducts;
    var dataSale = responseSale.docs;
    List filteredProducts = [];

    for (int i = 0; i < dataSale.length; i++) {
      if (dataSale[i]['isChecked'] == true) {
        DateTime singleD =
            DateTime.parse(dataSale[i]['date'].toDate().toString());
        if (singleD.compareTo(endDate) <= 0 &&
            singleD.compareTo(startDate) >= 0) {
          filteredProducts.add(dataSale[i]);
        }
      }
    }
    //--------------------------------

    return filteredProducts;
  }

  static Future<dynamic> findBests(startDate, endDate) async {
    List<dynamic> salesProducts =
        await getSelectedDateSalesProducts(startDate, endDate);
    var setpName = Set<String>();
    List<dynamic> uniquepName = salesProducts
        .where((data) => setpName.add(data['productName']))
        .toList();
    List<String> pNamesUnique;
    List<int> pNameCount = [];
    String? bestProduct;
    for (int i = 0; i < uniquepName.length; i++) {
      pNameCount.add(0);
      for (int j = 0; j < salesProducts.length; j++) {
        if (uniquepName[i]['productName'] == salesProducts[j]['productName']) {
          pNameCount[i] = pNameCount[i] + 1;
        }
      }
    }
    int maxProductCount = pNameCount.reduce(max);
    for (int i = 0; i < pNameCount.length; i++) {
      if (pNameCount[i] == maxProductCount) {
        bestProduct = uniquepName[i]['productName'];
      }
    }
    //--------------------
    List<dynamic> salesSale =
        await getSelectedDateSalesSales(startDate, endDate);

    var setcName = Set<String>();
    List<dynamic> uniquecName =
        salesSale.where((data) => setcName.add(data['customerName'])).toList();
    List<String> cNamesUnique;
    List<int> cNameCount = [];
    String? bestCustomer;
    for (int i = 0; i < uniquecName.length; i++) {
      cNameCount.add(0);
      for (int j = 0; j < salesSale.length; j++) {
        if (uniquecName[i]['customerName'] == salesSale[j]['customerName']) {
          cNameCount[i] = cNameCount[i] + 1;
        }
      }
    }
    int maxCustomerCount = cNameCount.reduce(max);
    for (int i = 0; i < cNameCount.length; i++) {
      if (cNameCount[i] == maxCustomerCount) {
        bestCustomer = uniquecName[i]['customerName'];
      }
    }

    //-------------------------

    var setpersonalName = Set<String>();
    List<dynamic> uniquepersonalName = salesSale
        .where((data) => setpersonalName.add(data['salesStaff']))
        .toList();
    List<String> personalNamesUnique;
    List<int> personalNameCount = [];
    String? bestPersonal;
    for (int i = 0; i < uniquepersonalName.length; i++) {
      personalNameCount.add(0);
      for (int j = 0; j < salesSale.length; j++) {
        if (uniquepersonalName[i]['salesStaff'] == salesSale[j]['salesStaff']) {
          personalNameCount[i] = personalNameCount[i] + 1;
        }
      }
    }
    int maxPersonalCount = personalNameCount.reduce(max);
    for (int i = 0; i < personalNameCount.length; i++) {
      if (personalNameCount[i] == maxPersonalCount) {
        bestPersonal = uniquepersonalName[i]['salesStaff'];
      }
    }

    //-------------------------
    var out = ({
      'bestCustomer': bestCustomer,
      'customerCount': maxCustomerCount,
      'bestProduct': bestProduct,
      'productCount': maxProductCount,
      'bestPersonal': bestPersonal,
      'personalCount': maxPersonalCount
    });

    return out;
  }

  static Future<dynamic> getFilteredProductsNames(startDate, endDate) async {
    List<dynamic> salesProducts =
        await getSelectedDateSalesProducts(startDate, endDate);
    var setpName = Set<String>();
    List<dynamic> uniquepName = salesProducts
        .where((data) => setpName.add(data['productName']))
        .toList();
    List<String> pNamesUnique;
    List<int> pNameCount = [];
    String? bestProduct;
    for (int i = 0; i < uniquepName.length; i++) {
      pNameCount.add(0);
      for (int j = 0; j < salesProducts.length; j++) {
        if (uniquepName[i]['productName'] == salesProducts[j]['productName']) {
          pNameCount[i] = pNameCount[i] + 1;
        }
      }
    }
    int maxProductCount = pNameCount.reduce(max);
    for (int i = 0; i < pNameCount.length; i++) {
      if (pNameCount[i] == maxProductCount) {
        bestProduct = uniquepName[i]['productName'];
      }
    }

    return uniquepName;
  }

  static Future<dynamic> getFilteredProductsCounts(startDate, endDate) async {
    List<dynamic> salesProducts =
        await getSelectedDateSalesProducts(startDate, endDate);
    var setpName = Set<String>();
    List<dynamic> uniquepName = salesProducts
        .where((data) => setpName.add(data['productName']))
        .toList();
    List<String> pNamesUnique;
    List<int> pNameCount = [];
    String? bestProduct;
    for (int i = 0; i < uniquepName.length; i++) {
      pNameCount.add(0);
      for (int j = 0; j < salesProducts.length; j++) {
        if (uniquepName[i]['productName'] == salesProducts[j]['productName']) {
          pNameCount[i] = pNameCount[i] + 1;
        }
      }
    }
    int maxProductCount = pNameCount.reduce(max);
    for (int i = 0; i < pNameCount.length; i++) {
      if (pNameCount[i] == maxProductCount) {
        bestProduct = uniquepName[i]['productName'];
      }
    }

    return pNameCount;
  }

  static Future<dynamic> getFilteredCustomerNames(startDate, endDate) async {
    List<dynamic> salesSale =
        await getSelectedDateSalesSales(startDate, endDate);

    var setcName = Set<String>();
    List<dynamic> uniquecName =
        salesSale.where((data) => setcName.add(data['customerName'])).toList();
    List<String> cNamesUnique;
    List<int> cNameCount = [];
    String? bestCustomer;
    for (int i = 0; i < uniquecName.length; i++) {
      cNameCount.add(0);
      for (int j = 0; j < salesSale.length; j++) {
        if (uniquecName[i]['customerName'] == salesSale[j]['customerName']) {
          cNameCount[i] = cNameCount[i] + 1;
        }
      }
    }
    int maxCustomerCount = cNameCount.reduce(max);
    for (int i = 0; i < cNameCount.length; i++) {
      if (cNameCount[i] == maxCustomerCount) {
        bestCustomer = uniquecName[i]['customerName'];
      }
    }

    return uniquecName;
  }

  static Future<dynamic> getFilteredCustomerCount(startDate, endDate) async {
    List<dynamic> salesSale =
        await getSelectedDateSalesSales(startDate, endDate);

    var setcName = Set<String>();
    List<dynamic> uniquecName =
        salesSale.where((data) => setcName.add(data['customerName'])).toList();
    List<String> cNamesUnique;
    List<int> cNameCount = [];
    String? bestCustomer;
    for (int i = 0; i < uniquecName.length; i++) {
      cNameCount.add(0);
      for (int j = 0; j < salesSale.length; j++) {
        if (uniquecName[i]['customerName'] == salesSale[j]['customerName']) {
          cNameCount[i] = cNameCount[i] + 1;
        }
      }
    }
    int maxCustomerCount = cNameCount.reduce(max);
    for (int i = 0; i < cNameCount.length; i++) {
      if (cNameCount[i] == maxCustomerCount) {
        bestCustomer = uniquecName[i]['customerName'];
      }
    }
    return cNameCount;
  }

  static Future<dynamic> getFilteredPersonalNames(startDate, endDate) async {
    List<dynamic> salesSale =
        await getSelectedDateSalesSales(startDate, endDate);
    var setpersonalName = Set<String>();
    List<dynamic> uniquepersonalName = salesSale
        .where((data) => setpersonalName.add(data['salesStaff']))
        .toList();
    List<String> personalNamesUnique;
    List<int> personalNameCount = [];
    String? bestPersonal;
    for (int i = 0; i < uniquepersonalName.length; i++) {
      personalNameCount.add(0);
      for (int j = 0; j < salesSale.length; j++) {
        if (uniquepersonalName[i]['salesStaff'] == salesSale[j]['salesStaff']) {
          personalNameCount[i] = personalNameCount[i] + 1;
        }
      }
    }
    int maxPersonalCount = personalNameCount.reduce(max);
    for (int i = 0; i < personalNameCount.length; i++) {
      if (personalNameCount[i] == maxPersonalCount) {
        bestPersonal = uniquepersonalName[i]['salesStaff'];
      }
    }

    return uniquepersonalName;
  }

  static Future<dynamic> getFilteredPersonalCount(startDate, endDate) async {
    List<dynamic> salesSale =
        await getSelectedDateSalesSales(startDate, endDate);
    var setpersonalName = Set<String>();
    List<dynamic> uniquepersonalName = salesSale
        .where((data) => setpersonalName.add(data['salesStaff']))
        .toList();
    List<String> personalNamesUnique;
    List<int> personalNameCount = [];
    String? bestPersonal;
    for (int i = 0; i < uniquepersonalName.length; i++) {
      personalNameCount.add(0);
      for (int j = 0; j < salesSale.length; j++) {
        if (uniquepersonalName[i]['salesStaff'] == salesSale[j]['salesStaff']) {
          personalNameCount[i] = personalNameCount[i] + 1;
        }
      }
    }
    int maxPersonalCount = personalNameCount.reduce(max);
    for (int i = 0; i < personalNameCount.length; i++) {
      if (personalNameCount[i] == maxPersonalCount) {
        bestPersonal = uniquepersonalName[i]['salesStaff'];
      }
    }

    return personalNameCount;
  }

  static Future<int> getInvoiceNumber() async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('invoiceNr');

    response = await _mainCollection.doc('invoice').get();
    var nr = response.data();
    int number = nr['number'];
    return number;
  }

  static Future updateInvoiceNumber(newInvoice) async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('invoiceNr');
    _mainCollection.doc('invoice').update({'number': newInvoice});
  }
}
