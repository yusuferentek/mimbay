import 'package:crm_app/services/personalService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPersonalScreen extends StatefulWidget {
  const AddPersonalScreen({Key? key}) : super(key: key);

  @override
  State<AddPersonalScreen> createState() => _AddPersonalScreenState();
}

class _AddPersonalScreenState extends State<AddPersonalScreen> {
  TextEditingController _fullNameCont = TextEditingController();
  TextEditingController _userNameCont = TextEditingController();
  TextEditingController _passCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Personal")),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 120),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 325,
                      child: TextField(
                        controller: _fullNameCont,
                        decoration: InputDecoration(
                          hintText: 'Enter the personal full name',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 325,
                      child: TextField(
                        controller: _userNameCont,
                        decoration: InputDecoration(
                          hintText: 'Enter the personal username',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 325,
                      child: TextField(
                        controller: _passCont,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter the personal Password.',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: InkWell(
                        child: Container(
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                              color: Colors.blueGrey),
                          child: Center(
                              child: Text(
                            'Add Personal',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                        ),
                        onTap: () {
                          PersonalService.addPersonal(_fullNameCont.text,
                              _userNameCont.text, _passCont.text);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Added!'),
                                  content: Text("Personal has been added."),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
