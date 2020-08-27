import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitted_text_field_container/fitted_text_field_container.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:anonymbot_frontend/test.dart';

void main() {
  runApp(MaterialApp(
    title: "NU Avenue",
    builder: (context, widget) => ResponsiveWrapper.builder(
      widget,
      // maxWidth: 1200,
      minWidth: 480,
      defaultScale: true,
      breakpoints: [
        ResponsiveBreakpoint.autoScaleDown(480, name: MOBILE),
        ResponsiveBreakpoint.autoScale(800, name: TABLET),
        ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      ],
      background: Container(
        color: Color.fromRGBO(0xE5, 0xE5, 0xE5, 100),
      ),
    ),
    theme: ThemeData(fontFamily: "ProximaNova"),
    routes: {
      "/": (context) => MainPage(),
      "/test": (context) => Test(),
      // "/myadmin": (context) => AdminPage(),
    },
    initialRoute: "/",
  ));
}

class MainPage extends StatefulWidget {
  @override
  createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // static final _formKey = GlobalKey<FormState>();
  final double _headerSize = 25.0;
  final double _btnTextSize = 20.0;
  TextEditingController _textController = TextEditingController();

  Future<http.Response> _submitMessage(text) async {
    const url = "http://185.86.77.120/anonymbot/";
    return await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": text}));
  }

  Widget _sendButton(BuildContext context) => SizedBox(
        width: double.infinity,
        child: FlatButton(
          color: Color.fromRGBO(0x00, 0x76, 0xD9, 100),
          focusColor: Color.fromRGBO(0x00, 0x76, 0xD9, 100),
          disabledColor: Color.fromRGBO(0x00, 0x76, 0xD9, 100),
          highlightColor: Color.fromRGBO(0x00, 0x76, 0xD9, 100),
          hoverColor: Color.fromRGBO(0x00, 0x76, 0xD9, 100),
          splashColor: Color.fromRGBO(0x00, 0x76, 0xD9, 100),
          textColor: Colors.white,
          onPressed: () => _sendMessage(context),
          child: Text(
            "Send",
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: _btnTextSize),
          ),
        ),
      );

  Widget _inputForm(width) {
    return TextField(
      minLines: 6,
      maxLengthEnforced: true,
      maxLength: 1000,
      maxLines: null,
      controller: _textController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return "Message cannot be empty";
      //   }
      //   return null;
      // },
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Your message here',
        fillColor: Color.fromRGBO(0xED, 0xEE, 0xF3, 100),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    print("sending message");
    String message = _textController.text;
    if (message.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Message cannot be empty!"),
      ));
    } else {
      print("text validated ${_textController.text}");
      _submitMessage(_textController.text).then((value) {
        _textController.text = "";
        if (value.statusCode == 200) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Message sent!")));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Ooops! Something went wrong, sorry ¯\\_(ツ)_/¯")));
        }
      });
    }
  }

  Widget _mobile(
      BuildContext context, double screenWidth, double screenHeight) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(0xE5, 0xE5, 0xE5, 100),
      body: Builder(builder: (BuildContext context) {
        return Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(),
            ),
            Expanded(
                flex: 88,
                child: Column(
                  children: [
                    Expanded(
                      flex: 20,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 30,
                      child: Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 2,
                          color: Color.fromRGBO(0xFF, 0xFF, 0xFF, 100),
                          child: Row(children: [
                            Expanded(
                              flex: 9,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 82,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 28,
                                    child: Center(
                                      child: Text(
                                        "NU Avenue",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: _headerSize),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 41,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color.fromRGBO(
                                            0xED, 0xEE, 0xF3, 100),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: _inputForm(screenWidth),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 31,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: _sendButton(context),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Container(),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 50,
                      child: Container(),
                    )
                  ],
                )),
            Expanded(
              flex: 6,
              child: Container(),
            ),
          ],
        );
      }),
    );
  }

  Widget _tablet(
      BuildContext context, double screenWidth, double screenHeight) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(0xE5, 0xE5, 0xE5, 100),
      body: Builder(builder: (BuildContext context) {
        return Row(
          children: [
            Expanded(
              flex: 10,
              child: Container(),
            ),
            Expanded(
                flex: 80,
                child: Column(
                  children: [
                    Expanded(
                      flex: 22,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 38,
                      child: Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          elevation: 2,
                          color: Color.fromRGBO(0xFF, 0xFF, 0xFF, 100),
                          child: Row(children: [
                            Expanded(
                              flex: 9,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 82,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 28,
                                    child: Center(
                                      child: Text(
                                        "NU Avenue",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: _headerSize),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 41,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color.fromRGBO(
                                            0xED, 0xEE, 0xF3, 100),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: _inputForm(screenWidth),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 31,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: _sendButton(context),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Container(),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 40,
                      child: Container(),
                    )
                  ],
                )),
            Expanded(
              flex: 10,
              child: Container(),
            ),
          ],
        );
      }),
    );
  }

  Widget _desktop(
      BuildContext context, double screenWidth, double screenHeight) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(0xE5, 0xE5, 0xE5, 100),
      body: Builder(builder: (BuildContext context) {
        return Row(
          children: [
            Expanded(
              flex: 30,
              child: Container(),
            ),
            Expanded(
                flex: 40,
                child: Column(
                  children: [
                    Expanded(
                      flex: 26,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 48,
                      child: Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          elevation: 2,
                          color: Color.fromRGBO(0xFF, 0xFF, 0xFF, 100),
                          child: Row(children: [
                            Expanded(
                              flex: 9,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 82,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 28,
                                    child: Center(
                                      child: Text(
                                        "NU Avenue",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: _headerSize),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 41,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color.fromRGBO(
                                            0xED, 0xEE, 0xF3, 100),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: _inputForm(screenWidth),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 31,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: _sendButton(context),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Container(),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 26,
                      child: Container(),
                    )
                  ],
                )),
            Expanded(
              flex: 30,
              child: Container(),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print("height $screenHeight, width $screenWidth");
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        print("Sizing ${sizingInformation.deviceScreenType}");
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return _tablet(context, screenWidth, screenHeight);
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.desktop) {
          return _desktop(context, screenWidth, screenHeight);
        }
        return _mobile(context, screenWidth, screenHeight);
      },
    );
  }
}
