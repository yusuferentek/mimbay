import 'package:crm_app/models/userModel.dart';
import 'package:crm_app/services/usermanagement.dart';
import 'package:crm_app/views/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        /*appBar: AppBar(
          title: const Text("Home"),
        ),*/
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26,horizontal: 36),
                child: Text(
                  "Welcome, X",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: Card(
                          color: Color.fromRGBO(64, 75, 96, .1),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Image.asset('assets/images/company.png',width: 64,),
                                const Text(
                                  "Best Customer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text("data",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: Card(
                          color: Color.fromRGBO(64, 75, 96, .1),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Image.asset('assets/images/box.png',width: 64,),
                                const Text(
                                  "Top Seller",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text("data",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: Card(
                          color: Color.fromRGBO(64, 75, 96, .1),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Image.asset('assets/images/personal.png',width: 64,),
                                const Text(
                                  "Best Personal",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text("data",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: Card(
                          color: Color.fromRGBO(64, 75, 96, .1),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Image.asset('assets/images/wait.png',width: 64,),
                                const Text(
                                  "Pending Order",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text("data",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
