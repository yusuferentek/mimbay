import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userManagement {
  static Future<String>? getUserAuth(String? username, password) async {
    List? pass = [];
    var response;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference userRef = _firestore.collection('users');

    try {
      response = await userRef.doc(username).get();
      Map<String, dynamic>? userDetail = response.data();
      var shared = await SharedPreferences.getInstance();
      pass.add(userDetail);
      if (pass[0]['password'] == password) {
        userModel.userRole = await pass[0]["role"];
        userModel.fullName = await pass[0]['fullName'];
        shared.setString('username', username ?? '');
        shared.setString('fullname', pass[0]['fullName'] ?? '');
        shared.setString('role', pass[0]['role'] ?? '');
        return pass[0]["role"];
      } else {
        return " ";
      }
    } on NoSuchMethodError {
      return " ";
    }
  }

  static Future<String> userIsLoggedIn() async {
    var shared = await SharedPreferences.getInstance();
    String username = shared.getString('username') ?? '';

    return username;
  }

  static Future<String> fullName() async {
    var shared = await SharedPreferences.getInstance();
    String fullname = shared.getString('fullname') ?? '';
    return fullname;
  }
}
