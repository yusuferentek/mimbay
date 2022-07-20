import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalService {
  static Future<List> getPersonal() async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('users');

    response = await _mainCollection.get();

    final allData = response.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  static Future<List> getPersonalDetail(username) async {
    var response;
    List data = [];
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('users');

    response = await _mainCollection.doc(username).get();

    var allData = response.data();
    data.add(allData);
    return data;
  }

  static Future<List>? getPersonalID() async {
    List data = [];
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('users');

    response = await _mainCollection.get();
    var customers = await response.docs;
    data.add(customers);

    return customers;
  }

  static Future changePass(String docID, newPass) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('users');

    _mainCollection.doc(docID).update({"password": newPass});
  }

  static Future addPersonal(
    String fullname,
    username,
    pass,
  ) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('users');

    _mainCollection.doc(username).set({
      "fullName": fullname,
      "username": username,
      "password": pass,
      "role": "worker",
      "saleCount": 0
    });
  }

  static Future deletePersonal(userID) async {
    var collection = FirebaseFirestore.instance.collection('users');
    await collection.doc(userID).delete();
  }
}
