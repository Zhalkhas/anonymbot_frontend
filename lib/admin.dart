import 'package:anonymbot_frontend/constants.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'dart:math';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<String> _blockedList = [];
  TextEditingController _newWordController = TextEditingController();

  Future<void> _getBlockedList() async {
    // http.Response responce = await http.get(urlApiAdmin + "/words");
    // return json.decode(responce.body)["wordlist"];
    return Future.delayed(
            Duration(seconds: 2), () => getRandomString(10).split(""))
        .then((value) => setState(() {
              _blockedList = value;
            }));
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    _rnd = Random();
    return FutureBuilder(
        future: _getBlockedList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Column(
                children: [
                  ListTile(
                      title: TextFormField(
                    controller: _newWordController,
                    decoration: InputDecoration(hintText: "New word in"),
                  )),
                  Center(
                    child: ListView.builder(
                      padding: EdgeInsets.all(50),
                      itemCount: _blockedList.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text("${_blockedList[index]}"),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              print("deleting");
                              _getBlockedList();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
