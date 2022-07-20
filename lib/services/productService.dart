import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  static Future<List> getSingleProductTemp() async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('categories');

    response = await _mainCollection
        .doc('singleProducts')
        .collection('products')
        .get();
    final data = response.docs.map((doc) => doc.data()).toList();

    return data;
  }

  static Future<List> getSetProductTemp() async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('categories');

    response =
        await _mainCollection.doc('setProducts').collection('sets').get();
    final data = response.docs.map((doc) => doc.data()).toList();

    return data;
  }

  static Future<List> getBoxProductTemp() async {
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('categories');

    response =
        await _mainCollection.doc('boxProducts').collection('boxes').get();
    final data = response.docs.map((doc) => doc.data()).toList();

    return data;
  }

  static Future<List> getAllProductTemp() async {
    List allData = [];
    allData.add(await getSingleProductTemp());
    allData.add(await getSetProductTemp());
    allData.add(await getBoxProductTemp());
    List ints3 = allData.fold([], (prev, curr) => prev + curr);

    return ints3;
  }

  static Future deleteSingle(productName) async {
    var collection = FirebaseFirestore.instance
        .collection('categories')
        .doc('singleProducts')
        .collection('products');
    await collection.doc(productName).delete();
  }

  static Future deleteSet(productName) async {
    var collection = FirebaseFirestore.instance
        .collection('categories')
        .doc('setProducts')
        .collection('sets');
    await collection.doc(productName).delete();
  }

  static Future deleteBox(productName) async {
    var collection = FirebaseFirestore.instance
        .collection('categories')
        .doc('boxProducts')
        .collection('boxes');
    await collection.doc(productName).delete();
  }

  static Future<List> getProductDetail(String type, productName) async {
    if (type == 'set') {
      List data = [];
      var response;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final CollectionReference _mainCollection =
          _firestore.collection('categories');

      response = await _mainCollection
          .doc('setProducts')
          .collection('sets')
          .doc(productName)
          .get();
      var datas = await response.data();

      data.add(datas);
      return data;
    } else if (type == 'box') {
      List data = [];
      var response;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final CollectionReference _mainCollection =
          _firestore.collection('categories');

      response = await _mainCollection
          .doc('boxProducts')
          .collection('boxes')
          .doc(productName)
          .get();
      var datas = await response.data();

      data.add(datas);
      return data;
    } else {
      List data = [];
      var response;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final CollectionReference _mainCollection =
          _firestore.collection('categories');

      response = await _mainCollection
          .doc('singleProducts')
          .collection('products')
          .doc(productName)
          .get();
      var datas = await response.data();

      data.add(datas);
      return data;
    }
  }

  static Future addSingleProduct(
      String color, colorPrice, pName, size, stock) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('categories');

    _mainCollection
        .doc('singleProducts')
        .collection('products')
        .doc(pName)
        .set({
      'color': color,
      'colorPrice': colorPrice,
      'productName': pName,
      'size': size,
      'stock': stock,
      'type': 'single'
    });
  }

  static Future updateSingleProduct(
      String color, colorPrice, pName, size, stock) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('categories');

    _mainCollection
        .doc('singleProducts')
        .collection('products')
        .doc(pName)
        .update({
      'color': color,
      'colorPrice': colorPrice,
      'productName': pName,
      'size': size,
      'stock': stock,
      'type': 'single'
    });
  }

  static Future addSetProduct(String napkinColor, napkinColorPrice, unitPrice,
      setName, setContent, setStock, wetwipesColor, wetwipesColorPrice) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('categories');

    _mainCollection.doc('setProducts').collection('sets').doc(setName).set({
      'napkinColor': napkinColor,
      'napkinColorPrice': napkinColorPrice,
      'productName': setName,
      'setContent': setContent,
      'setStock': setStock,
      'wetwipesColor': wetwipesColor,
      'price': unitPrice,
      'wetwipesColorPrice': wetwipesColorPrice,
      'type': 'set',
      'sellCount': 0,
    });
  }

  static Future updateSetProduct(
      String napkinColor,
      napkinColorPrice,
      unitPrice,
      setName,
      setContent,
      setStock,
      wetwipesColor,
      wetwipesColorPrice) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('categories');

    _mainCollection.doc('setProducts').collection('sets').doc(setName).update({
      'napkinColor': napkinColor,
      'napkinColorPrice': napkinColorPrice,
      'productName': setName,
      'setContent': setContent,
      'setStock': setStock,
      'wetwipesColor': wetwipesColor,
      'price': unitPrice,
      'wetwipesColorPrice': wetwipesColorPrice,
      'type': 'set',
      'sellCount': 0,
    });
  }

  static Future addBoxProduct(
      String boxName, lidStock, boxStock, boxSizePrice, lidSizePrice) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('categories');

    _mainCollection.doc('boxProducts').collection('boxes').doc(boxName).set({
      'lidStock': lidStock,
      'productName': boxName,
      'lidSize': lidSizePrice,
      'boxStock': boxStock,
      'boxSize': boxSizePrice,
      'type': 'box',
      'sellCount': 0,
    });
  }

  static Future updateBoxProduct(
      String boxName, lidStock, boxStock, boxSizePrice, lidSizePrice) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection('categories');

    _mainCollection.doc('boxProducts').collection('boxes').doc(boxName).update({
      'lidStock': lidStock,
      'productName': boxName,
      'lidSize': lidSizePrice,
      'boxStock': boxStock,
      'boxSize': boxSizePrice,
      'type': 'box',
      'sellCount': 0,
    });
  }
}
