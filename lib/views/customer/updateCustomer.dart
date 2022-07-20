import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/customerService.dart';

class UpdateCustomerScreen extends StatefulWidget {
  const UpdateCustomerScreen({
    Key? key,
    required this.compName,
    required this.compPhone,
    required this.compAddress,
    required this.authName,
    required this.authPhone,
    required this.customerRef,
    required this.compPostCode,
  }) : super(key: key);
  final compName,
      compPhone,
      compAddress,
      authName,
      authPhone,
      customerRef,
      compPostCode;
  @override
  State<UpdateCustomerScreen> createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  TextEditingController compNameCont = TextEditingController();
  TextEditingController compPhoneCont = TextEditingController();
  TextEditingController compAddressCont = TextEditingController();
  TextEditingController authNameCont = TextEditingController();
  TextEditingController authPhoneCont = TextEditingController();
  TextEditingController customerRefCont = TextEditingController();
  TextEditingController compPostCodeCont = TextEditingController();

  void initState() {
    compNameCont.text = widget.compName;
    compPhoneCont.text = widget.compPhone;
    compAddressCont.text = widget.compAddress;
    authNameCont.text = widget.authName;
    authPhoneCont.text = widget.authPhone;
    customerRefCont.text = widget.customerRef;
    compPostCodeCont.text = widget.compPostCode;
    super.initState();
  }

  Widget _companyNameTF() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      width: 300,
      child: TextField(
        enabled: false,
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
                        CustomerService.updateCustomer(
                            widget.compName,
                            authNameCont.text,
                            authPhoneCont.text,
                            compAddressCont.text,
                            compNameCont.text,
                            compPhoneCont.text,
                            customerRefCont.text,
                            compPostCodeCont.text);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Succes"),
                              content: Text("Customer Updated!"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();

                                      Navigator.of(context).pop();
                                      setState(() {});
                                    },
                                    child: Text("OK"))
                              ],
                            );
                          },
                        );
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
