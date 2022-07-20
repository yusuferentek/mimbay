import 'package:crm_app/invoiceNr.dart';
import 'package:crm_app/views/loginScreen.dart';
import 'package:crm_app/views/personal/addPersonal.dart';
import 'package:crm_app/views/personal/personals.dart';
import 'package:crm_app/views/product/addProduct_1.dart';
import 'package:crm_app/views/product/products.dart';
import 'package:crm_app/views/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../product/editProductCategories.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Settings"),
      ),
      body: Container(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: Text(
                'Personal',
              ),
              tiles: [
                SettingsTile(
                  title: Text(
                    'Add Personal',
                  ),
                  //description: Text('Add New Personal'),
                  leading: Icon(Icons.person_add),
                  onPressed: (context) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddPersonalScreen()));
                  },
                ),
                SettingsTile(
                  title: Text('Personals'),
                  leading: Icon(Icons.person),
                  onPressed: (context) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PersonalScreen()));
                  },
                ),
              ],
            ),
            SettingsSection(
              title: Text('Product'),
              tiles: [
                SettingsTile(
                  title: Text('Add Product'),
                  leading: Icon(Icons.add_box),
                  onPressed: (context) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddProductCategoriesScreen()));
                  },
                ),
                SettingsTile(
                  title: Text('Edit Product'),
                  leading: Icon(Icons.mode_edit_outline_outlined),
                  onPressed: (context) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProductCategoriesScreen()));
                  },
                ),
                SettingsTile(
                  title: Text('All Products'),
                  leading: Icon(Icons.widgets),
                  onPressed: (context) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductScreen()));
                  },
                ),
              ],
            ),
            SettingsSection(
              title: Text('Documents'),
              tiles: [
                SettingsTile(
                  title: const Text('Reports'),
                  leading: const Icon(Icons.description),
                  onPressed: (context) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReportScreen()));
                  },
                ),
              ],
            ),
            SettingsSection(
              title: Text('Other'),
              tiles: [
                SettingsTile(
                  title: const Text('Invoice Number'),
                  leading: const Icon(Icons.description),
                  onPressed: (context) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InvoiceNr()));
                  },
                ),
              ],
            ),
            SettingsSection(
              title: Text('Account'),
              tiles: [
                SettingsTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                  onPressed: (context) async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Are you sure?'),
                            content:
                                const Text("Are you sure you want to log out?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () async {
                                  await preferences.clear();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
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
            )
          ],
        ),
      ),
    );
  }
}
