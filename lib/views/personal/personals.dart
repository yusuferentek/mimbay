import 'package:crm_app/services/personalService.dart';
import 'package:crm_app/views/personal/changePass.dart';
import 'package:flutter/material.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  String? query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Personals"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black, width: 1.5))),
          height: 60.0,
          child: TextField(
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search Personal',
              hintStyle:
                  TextStyle(color: Colors.white54, fontFamily: 'OpenSans'),
            ),
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
          ),
        ),
        //SizedBox(height: 10,),
        Expanded(
          child: FutureBuilder<dynamic>(
            future: PersonalService.getPersonal(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder<dynamic>(
                    future: PersonalService.getPersonalID(),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            if (query != null &&
                                snapshot.data[index]['username']
                                    .toLowerCase()
                                    .contains(query)) {
                              return InkWell(
                                child: Card(
                                  elevation: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(64, 75, 96, .9)),
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                        leading: Container(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            decoration: new BoxDecoration(
                                                border: new Border(
                                                    right: new BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Colors.white24))),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/personal.png'))),
                                            )),
                                        title: Text(
                                          "${snapshot.data[index]["username"]}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                        subtitle: Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                                "${snapshot.data[index]["role"]}",
                                                style: TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                        trailing: InkWell(
                                          child: Icon(Icons.delete,
                                              color: Colors.red, size: 30.0),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Are you sure?'),
                                                    content: const Text(
                                                        "Are you sure you want to delete this personal?"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                            const Text('Yes!'),
                                                        onPressed: () {
                                                          PersonalService
                                                              .deletePersonal(
                                                                  snapshots
                                                                      .data[
                                                                          index]
                                                                      .id);
                                                          Navigator.of(context)
                                                              .pop();
                                                          //Navigator.of(context).pop();
                                                          setState(() {});
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                        )),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChangePassScreen(
                                            userID: snapshots.data[index].id,
                                            userName: snapshot.data[index]
                                                ['username'],
                                          )));
                                },
                              );
                            } else if (query == null || query == "") {
                              return InkWell(
                                child: Card(
                                  elevation: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(64, 75, 96, .9)),
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                        leading: Container(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.white24))),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/personal.png'))),
                                          ),
                                        ),
                                        title: Text(
                                          "${snapshot.data[index]["username"]}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                        subtitle: Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                                "${snapshot.data[index]["role"]}",
                                                style: TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                        trailing: InkWell(
                                          child: Icon(Icons.delete,
                                              color: Colors.red, size: 30.0),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Are you sure?'),
                                                    content: const Text(
                                                        "Are you sure you want to delete this personal?"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                            const Text('Yes!'),
                                                        onPressed: () {
                                                          PersonalService
                                                              .deletePersonal(
                                                                  snapshots
                                                                      .data[
                                                                          index]
                                                                      .id);
                                                          Navigator.of(context)
                                                              .pop();
                                                          //Navigator.of(context).pop();
                                                          setState(() {});
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                        )),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChangePassScreen(
                                            userID: snapshots.data[index].id,
                                            userName: snapshot.data[index]
                                                ['username'],
                                          )));
                                },
                              );
                            } else {
                              return Center();
                            }
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}
