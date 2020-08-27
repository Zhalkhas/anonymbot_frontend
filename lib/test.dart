import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            TextFormField(
              expands: true,
              controller: TextEditingController(),
              validator: (value) {
                if (value.isEmpty) {
                  return "Message cannot be empty";
                }
                return null;
              },
              minLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Your message here',
                fillColor: Color.fromRGBO(0xED, 0xEE, 0xF3, 100),
              ),
            ),
            Text("Width: ${MediaQuery.of(context).size.width}",
                style: Theme.of(context).textTheme.headline4),
            Text("Height: ${MediaQuery.of(context).size.height}",
                style: Theme.of(context).textTheme.headline4)
          ])));
}
