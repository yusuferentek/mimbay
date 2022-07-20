import 'package:crm_app/services/customerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  TextEditingController compNameCont = TextEditingController();
  TextEditingController compPhoneCont = TextEditingController();
  TextEditingController compAddressCont = TextEditingController();
  TextEditingController authNameCont = TextEditingController();
  TextEditingController authPhoneCont = TextEditingController();
  TextEditingController customerRefCont = TextEditingController();
  TextEditingController compPostCodeCont = TextEditingController();
  Widget _companyNameTF() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      width: 300,
      child: TextField(
        controller: compNameCont,
        style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.corporate_fare,
            color: Colors.white,
          ),
          hintText: 'Company Name',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _companyPostCodeTF() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      width: 300,
      child: TextField(
        controller: compPostCodeCont,
        style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.white,
          ),
          hintText: 'Company Post Code',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _companyPhoneTF() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      width: 300,
      child: TextField(
        controller: compPhoneCont,
        keyboardType: TextInputType.phone,
        style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.white,
          ),
          hintText: 'Company Phone',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _companyAddressTF() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      width: 300,
      child: TextField(
        controller: compAddressCont,
        minLines: 1,
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.location_city,
            color: Colors.white,
          ),
          hintText: 'Company Address',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'OpenSans'),
          hintMaxLines: 5,
        ),
      ),
    );
  }

  Widget _personNameTF() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      width: 300,
      child: TextField(
        controller: authNameCont,
        style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.location_city,
            color: Colors.white,
          ),
          hintText: 'Auth Personal Name',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'OpenSans'),
          hintMaxLines: 5,
        ),
      ),
    );
  }

  Widget _personPhoneTF() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      width: 300,
      child: TextField(
        controller: authPhoneCont,
        keyboardType: TextInputType.phone,
        style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.location_city,
            color: Colors.white,
          ),
          hintText: 'Auth Person Phone',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'OpenSans'),
          hintMaxLines: 5,
        ),
      ),
    );
  }

  Widget _customerRefTF() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      width: 300,
      child: TextField(
        controller: customerRefCont,
        style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.location_city,
            color: Colors.white,
          ),
          hintText: 'Customer Reference',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'OpenSans'),
          hintMaxLines: 5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add Customer"),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Center(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Company",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _companyNameTF(),
                    const SizedBox(
                      height: 30,
                    ),
                    _companyPhoneTF(),
                    const SizedBox(
                      height: 30,
                    ),
                    _companyAddressTF(),
                    const SizedBox(
                      height: 25,
                    ),
                    _companyPostCodeTF(),
                    const SizedBox(
                      height: 25,
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                      thickness: 3,
                      indent: 10,
                      endIndent: 10,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Authorized Person",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _personNameTF(),
                    const SizedBox(
                      height: 30,
                    ),
                    _personPhoneTF(),
                    const SizedBox(height: 30),
                    _customerRefTF(),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        CustomerService.addCustomerTemp(
                            compNameCont.text,
                            compPhoneCont.text,
                            compAddressCont.text,
                            authNameCont.text,
                            authPhoneCont.text,
                            customerRefCont.text,
                            compPostCodeCont.text);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Succes"),
                              content: Text("Customer Added!"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"))
                              ],
                            );
                          },
                        );
                        compNameCont.clear();
                        compPhoneCont.clear();
                        compAddressCont.clear();
                        authNameCont.clear();
                        authPhoneCont.clear();
                        customerRefCont.clear();
                      },
                      child: const Text("   SAVE   "),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )),
          ),
        ));
  }
}
