import 'package:crm_app/services/personalService.dart';
import 'package:crm_app/services/usermanagement.dart';
import 'package:crm_app/views/homePage.dart';
import 'package:crm_app/views/loginScreen.dart';
import 'package:crm_app/views/navigator.dart';
import 'package:crm_app/models/userModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().catchError((e) {
    print(e);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userManagement.userIsLoggedIn(),
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.data == '' || snapshot.data == null
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData.dark(),
                  home: LoginScreen(),
                )
              : MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData.dark(),
                  home: FutureBuilder<dynamic>(
                    future: PersonalService.getPersonalDetail(snapshot.data),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        if (snapshots.data[0]['role'] == 'admin') {
                          
                          userModel.userRole = snapshots.data[0]['role'];
                          return NavigatorScreen();
                        } else {
                          userModel.userRole = snapshots.data[0]['role'];
                          return NavigatorScreen();
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                );
        });
  }
}
