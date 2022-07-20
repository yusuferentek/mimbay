import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateSingleSaleScreen extends StatefulWidget {
  const CreateSingleSaleScreen({Key? key}) : super(key: key);

  @override
  State<CreateSingleSaleScreen> createState() => _CreateSingleSaleScreenState();
}

class _CreateSingleSaleScreenState extends State<CreateSingleSaleScreen> {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Sale'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
