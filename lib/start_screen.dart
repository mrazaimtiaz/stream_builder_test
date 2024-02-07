import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:stream_builder_test/main_screen.dart';
import 'package:stream_builder_test/model/item.dart';

class StartScreen extends StatefulWidget {
  StartScreen();

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //number stream
  final number = BehaviorSubject<int>();
  Function(int) get changeNumber => number.sink.add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[],
        title: Text("Home Screen"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (number.hasValue == false) {
              changeNumber(1);
            } else {
              changeNumber(number.value + 1);
            }
          },
          child: Icon(Icons.add)),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Click below button to learn more about stream builder"),
            SingleChildScrollView(
                child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ));
              },
              child: Text("Navigate to Main Screen"),
            )),
            SizedBox(
              height: 50,
            ),
            Text("Click floating action button to change below int value"),
            StreamBuilder<int>(
                stream: number,
                initialData: 0,
                builder: (context, snapshot) {
                  int? value = snapshot.data;
                  return value != null
                      ? Text(
                          value.toString(),
                          style: TextStyle(fontSize: 40),
                        )
                      : Container();
                })
          ],
        ),
      ),
    );
  }
}
