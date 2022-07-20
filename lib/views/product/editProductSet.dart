import 'package:crm_app/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductSetScreen extends StatefulWidget {
  const EditProductSetScreen(
      {Key? key, required this.productName, required this.productType})
      : super(key: key);
  final productName;
  final productType;
  @override
  State<EditProductSetScreen> createState() => _EditProductSetScreenState();
}

class _EditProductSetScreenState extends State<EditProductSetScreen> {
  TextEditingController _setName = TextEditingController();
  TextEditingController _napkinColor = TextEditingController();
  TextEditingController _napkinColorPrice = TextEditingController();
  TextEditingController _wetWipesColor = TextEditingController();
  TextEditingController _wetWipesColorPrice = TextEditingController();
  TextEditingController _setContent = TextEditingController();
  TextEditingController _setStock = TextEditingController();
  TextEditingController _unitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Set Product")),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: FutureBuilder<dynamic>(
                future: ProductService.getProductDetail(
                    widget.productType, widget.productName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _setName.text = snapshot.data[0]['productName'].toString();
                    _napkinColor.text =
                        snapshot.data[0]['napkinColor'].toString();
                    _napkinColorPrice.text =
                        snapshot.data[0]['napkinColorPrice'].toString();
                    _wetWipesColor.text =
                        snapshot.data[0]['wetwipesColor'].toString();
                    _wetWipesColorPrice.text =
                        snapshot.data[0]['wetwipesColorPrice'].toString();
                    _setContent.text =
                        snapshot.data[0]['setContent'].toString();
                    _setStock.text = snapshot.data[0]['setStock'].toString();
                    _unitPrice.text = snapshot.data[0]['price'].toString();
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //-----
                          Container(
                            width: 325,
                            child: TextField(
                              enabled: false,
                              controller: _setName,
                              decoration: InputDecoration(
                                hintText: 'Enter the set name',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          //------
                          Container(
                            width: 325,
                            child: TextField(
                              controller: _napkinColor,
                              decoration: InputDecoration(
                                hintText: 'Enter the napkin colors',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Entry type(napkin color): none,color1,color2,color3 \n example:none,1,2,3,4',
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          //------
                          Container(
                            width: 325,
                            child: TextField(
                              controller: _napkinColorPrice,
                              decoration: InputDecoration(
                                hintText: 'Enter the napkin color prices',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Entry type(napkin color price): price1,price2,price3,other \n example:50,75,100,125,other',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          //------

                          Container(
                            width: 325,
                            child: TextField(
                              controller: _wetWipesColor,
                              decoration: InputDecoration(
                                hintText: 'Enter the Wet Wipes colors',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Entry type(wetwipes color): none,color1,color2,color3 \n example:none,1,2,3,4',
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          //-------------

                          Container(
                            width: 325,
                            child: TextField(
                              controller: _wetWipesColorPrice,
                              decoration: InputDecoration(
                                hintText: 'Enter the wet wipes color prices',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Entry type(wetwipes color price): price1,price2,price3,other \n example:50,75,100,125,other',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          //------

                          Container(
                            width: 325,
                            child: TextField(
                              controller: _setContent,
                              decoration: InputDecoration(
                                hintText: 'Enter the set content.',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Entry type(set content): content1,content2,content3',
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          //------

                          Container(
                            width: 325,
                            child: TextField(
                              controller: _unitPrice,
                              decoration: InputDecoration(
                                hintText: 'Enter the unit price.',
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Enter the unit price.',
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          //------

                          Container(
                            width: 325,
                            child: TextField(
                              controller: _setStock,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Enter the set stock',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Enter the set stock',
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          //------
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
                                  'Update Set Product',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              onTap: () {
                                ProductService.updateSetProduct(
                                    _napkinColor.text,
                                    _napkinColorPrice.text,
                                    _unitPrice.text,
                                    _setName.text,
                                    _setContent.text,
                                    _setStock.text,
                                    _wetWipesColor.text,
                                    _wetWipesColorPrice.text);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Added!'),
                                        content:
                                            Text("Product has been updated."),
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
                        ]);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
