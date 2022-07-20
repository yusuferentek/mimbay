import 'package:crm_app/models/userModel.dart';
import 'package:crm_app/services/personalService.dart';
import 'package:crm_app/services/usermanagement.dart';
import 'package:crm_app/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Container(
              width: 371,
              height: 50,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/newLogo.png')))),
          actions: [
            FutureBuilder<String>(
              future: userManagement.userIsLoggedIn(),
              builder: (context, snapshotss) {
                return FutureBuilder<dynamic>(
                  future: PersonalService.getPersonalDetail(snapshotss.data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data[0]['role'] == 'admin') {
                        userModel.userRole = 'admin';
                        return Container();
                      } else {
                        return InkWell(
                          child: const Icon(Icons.logout),
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Are you sure?'),
                                    content: const Text(
                                        "Are you sure you want to log out?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () async {
                                          await preferences.clear();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()));
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
                );
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                  width: 170,
                  height: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/britishLogo.png')))),
              const SizedBox(
                height: 50,
              ),
              FutureBuilder(
                  future: userManagement.fullName(),
                  builder: (context, snapshot) {
                    return Text(
                      'Welcome, ${snapshot.data}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    );
                  }),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Use the navigation bar below to take action.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                  width: 371,
                  height: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/arrow.png')))),
            ],
          ),
        ));
  }
}
