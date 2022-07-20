import 'package:crm_app/models/userModel.dart';
import 'package:crm_app/views/customer/customers.dart';
import 'package:crm_app/views/home.dart';
import 'package:crm_app/views/personal/personals.dart';
import 'package:crm_app/views/product/products.dart';
import 'package:crm_app/views/sales/sales.dart';
import 'package:crm_app/views/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crm_app/services/usermanagement.dart';
import '../services/personalService.dart';
import 'homePage.dart';
import 'loginScreen.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomePageScreen(),
          CustomerScreen(),
          ProductScreen(),
          SaleScreen(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Customers'),
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Sales'),

          if (userModel.userRole == "admin") ...[
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ]
          //BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
      ),
    );
  }
}
