import 'package:crm_app/services/personalService.dart';
import 'package:crm_app/views/personal/personals.dart';
import 'package:flutter/material.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen(
      {Key? key, required this.userName, required this.userID})
      : super(key: key);
  final userName;
  final userID;
  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController _passCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change ${widget.userName} Password")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 325,
            child: TextField(
              controller: _passCont,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter the new Password.',
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
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    color: Colors.blueGrey),
                child: Center(
                    child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
              ),
              onTap: () {
                PersonalService.changePass(widget.userID, _passCont.text);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Changed!'),
                        content: Text("Password has been changed."),
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
        ],
      ),
    );
  }
}
