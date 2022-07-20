import 'package:crm_app/services/saleService.dart';
import 'package:flutter/material.dart';

class RecentDetailScreen extends StatefulWidget {
  const RecentDetailScreen(
      {Key? key, required this.saleID, required this.recentID})
      : super(key: key);
  final saleID, recentID;
  @override
  State<RecentDetailScreen> createState() => _RecentDetailScreenState();
}

class _RecentDetailScreenState extends State<RecentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: const Text('Recent Detail'),
      ),
      body: FutureBuilder<dynamic>(
        future: SaleService.getRecentProducts(widget.saleID, widget.recentID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data[0]['type']) {
              case 'single':
                return Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(58, 66, 86, 1.0),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.recentID}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "${snapshot.data[0]['productName']}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    //decoration: BoxDecoration(color: Colors.grey.shade400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Product Size: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${snapshot.data[0]['productSize']}"),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Product Color: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${snapshot.data[0]['productColor']}"),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Product Color Price: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                      "${snapshot.data[0]['productColorPrice']}")),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Amount: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(" ${snapshot.data[0]['piece']}"),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Price: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(" ${snapshot.data[0]['price']}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]);

              case 'set':
                return Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(58, 66, 86, 1.0),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.recentID}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "${snapshot.data[0]['productName']}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    //decoration: BoxDecoration(color: Colors.grey.shade400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Napkin Color: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  "${snapshot.data[0]['napkinColor']}",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Napkin Color Price: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                      "${snapshot.data[0]['napkinColorPrice']}")),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Wet Wipes Color: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${snapshot.data[0]['wetwipesColor']}"),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Wet Wipes Color Price:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${snapshot.data[0]['wetwipesColor']}"),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Selected Content:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                      " ${snapshot.data[0]['selectedContent']}")),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Amount: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${snapshot.data[0]['piece']}"),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Price: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${snapshot.data[0]['price']}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]);

              case 'box':
                return Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(58, 66, 86, 1.0),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.recentID}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "${snapshot.data[0]['productName']}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    //decoration: BoxDecoration(color: Colors.grey.shade400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("Box Size: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(" ${snapshot.data[0]['boxSize']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text("Lid Size: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(" ${snapshot.data[0]['lidSize']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text("Box is Printed(Print Price): ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(
                                    " ${snapshot.data[0]['boxIsPrinted']}(${snapshot.data[0]['boxPrintPrice']})",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text("Lid is Printed(Print Price): ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(
                                    " ${snapshot.data[0]['lidIsPrinted']}(${snapshot.data[0]['lidPrintPrice']})",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text("Box Amount: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text("${snapshot.data[0]['boxAmount']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const Text("Lid Amount: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text("${snapshot.data[0]['lidAmount']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  )
                ]);
              default:
                return const CircularProgressIndicator();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
