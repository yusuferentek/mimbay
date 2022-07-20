import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_app/services/saleService.dart';
import 'package:flutter/material.dart';

class CustomerService {
  static Future<void>? addCustomerTemp(String companyName, companyPhone,
      companyAddress, authName, authPhone, customerRef, postCode) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('customers');

    _mainCollection
        .doc(companyName)
        .set({
          'companyName': companyName,
          'companyPhone': companyPhone,
          'companyAddress': companyAddress,
          'authName': authName,
          'authPhone': authPhone,
          'customerRef': customerRef,
          'postCode': postCode,
          'dateOfUpload': DateTime.now()
        })
        .then((value) => debugPrint("Customer Added"))
        .catchError((error) => debugPrint("Failed to add Customer: $error"));
  }

  static Future deleteCustomer(companyName) async {
    var collection = FirebaseFirestore.instance.collection('customers');
    await collection.doc(companyName).delete();
  }

  static Future<List>? getCustomerTemp() async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('customers');

    response = await _mainCollection.get();

    final allData = response.docs.map((doc) => doc.data()).toList();
    //var customerTempList = response.data();
    //data.add(await customerTempList);

    return allData;
  }

  static Future<List>? getCustomerID() async {
    List data = [];
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('customers');

    response = await _mainCollection.get();
    var customers = await response.docs;
    data.add(customers);
    //final allData = response.docs.map((doc) => doc.data()).toList();
    //var customerTempList = response.data();
    //data.add(await customerTempList);

    return customers;
  }

  static Future<List<String>> getCompanyName() async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('customers');

    response = await _mainCollection.snapshots();

    var allItems = await getCustomerTemp()!;
    var companyName;
    for (int i = 0; i < allItems.length; i++) {
      companyName[i] = allItems[i]['companyName'];
    }

    return response;
  }

  static Future<List> getCustomerDetail(String id) async {
    List data = [];
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('customers');

    response = await _mainCollection.doc(id).get();
    var datas = await response.data();

    data.add(datas);
    return data;
  }

  static Future updateCustomer(id, authName, authPhone, companyAddress,
      companyName, companyPhone, customerRef, postCode) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('customers');
    await _mainCollection.doc(id).update({
      'authName': authName,
      'authPhone': authPhone,
      'companyAddress': companyAddress,
      'companyName': companyName,
      'companyPhone': companyPhone,
      'customerRef': customerRef,
      'postCode': postCode
    });
  }

  static Future<List> getCustomerReportsPname(
      customerName, startDate, endDate) async {
    var response;
    List<dynamic> sales =
        await SaleService.getSelectedDateSalesSales(startDate, endDate);
    List son = [];
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('sales');

    response = await _mainCollection.get();

    var allData = response.docs;
    for (int i = 0; i < sales.length; i++) {
      var saleProducts;
      var responseProduct;
      if (sales[i]['customerName'] == customerName) {
        responseProduct =
            await _mainCollection.doc(sales[i].id).collection('products').get();
        saleProducts = responseProduct.docs;
        son.addAll(saleProducts);
      }
    }

    for (int i = 0; i < son.length; i++) {}

    var setpName = Set<String>();
    List<dynamic> uniquepName =
        son.where((data) => setpName.add(data['productName'])).toList();
    List<String> pNamesUnique;
    List<int> pNameCount = [];
    String? bestProduct;
    for (int i = 0; i < uniquepName.length; i++) {
      pNameCount.add(0);
      for (int j = 0; j < son.length; j++) {
        if (uniquepName[i]['productName'] == son[j]['productName']) {
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

  static Future<List> getCustomerReportsPcount(
      customerName, startDate, endDate) async {
    var response;
    List<dynamic> sales =
        await SaleService.getSelectedDateSalesSales(startDate, endDate);
    List son = [];
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('sales');

    response = await _mainCollection.get();

    var allData = response.docs;
    for (int i = 0; i < sales.length; i++) {
      var saleProducts;
      var responseProduct;
      if (sales[i]['customerName'] == customerName) {
        responseProduct =
            await _mainCollection.doc(sales[i].id).collection('products').get();
        saleProducts = responseProduct.docs;
        son.addAll(saleProducts);
      }
    }

    for (int i = 0; i < son.length; i++) {}

    var setpName = Set<String>();
    List<dynamic> uniquepName =
        son.where((data) => setpName.add(data['productName'])).toList();
    List<String> pNamesUnique;
    List<int> pNameCount = [];
    String? bestProduct;
    for (int i = 0; i < uniquepName.length; i++) {
      pNameCount.add(0);
      for (int j = 0; j < son.length; j++) {
        if (uniquepName[i]['productName'] == son[j]['productName']) {
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
}
