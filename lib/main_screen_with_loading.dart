import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:stream_builder_test/model/item.dart';

class MainScreenWithLoading extends StatefulWidget {
  MainScreenWithLoading();

  @override
  _MainScreenWithLoadingState createState() => _MainScreenWithLoadingState();
}

class _MainScreenWithLoadingState extends State<MainScreenWithLoading> {
  @override
  void initState() {
    var dummyList = [
      Item(PKID: 1, NameEn: "Orrange", NameAr: "Orrange arabic"),
      Item(PKID: 3, NameEn: "Apple", NameAr: "Apple arabic"),
      Item(PKID: 4, NameEn: "Strawberry", NameAr: "Strawberry arabic"),
      Item(PKID: 5, NameEn: "Pineapple", NameAr: "Pineapple arabic"),
      Item(PKID: 6, NameEn: "Guava", NameAr: "Guava arabic"),
      Item(PKID: 7, NameEn: "Mango", NameAr: "Mango arabic"),
      Item(PKID: 8, NameEn: "Kiwi", NameAr: "Kiwi arabic"),
      Item(PKID: 9, NameEn: "Red berry", NameAr: "Red berry arabic"),
      Item(PKID: 10, NameEn: "Blue berry", NameAr: "Blue berry arabic"),
      Item(PKID: 11, NameEn: "Pak", NameAr: "pak arabic"),
      Item(PKID: 12, NameEn: "Ind", NameAr: "Ind arabic"),
      Item(PKID: 13, NameEn: "kwt", NameAr: "kwt arabic"),
      Item(PKID: 14, NameEn: "Saud", NameAr: "Saud arabic"),
      Item(PKID: 15, NameEn: "Orrange2", NameAr: "Orrange arabic2"),
      Item(PKID: 16, NameEn: "Orrange2", NameAr: "Orrange arabic2"),
      Item(PKID: 17, NameEn: "Apple2", NameAr: "Apple arabic2"),
    ];
    changeListOfItems(dummyList);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //loading stream
  final isLoading = BehaviorSubject<bool>();
  Function(bool) get changeIsLoading => isLoading.sink.add;

  final title = BehaviorSubject<String>();
  Function(String) get changeTitle => title.sink.add;

  final listOfItems = BehaviorSubject<List<Item>>();
  Function(List<Item>) get changeListOfItems => listOfItems.sink.add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[],
        title: StreamBuilder<String>(
            stream: title,
            builder: (context, snapshot) {
              return Text(
                  snapshot.hasData ? snapshot.data ?? "" : "No Item Selected");
            }),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              StreamBuilder<bool>(
                  stream: isLoading,
                  builder: (context, snapshot) {
                    var isLoading = snapshot.data;
                    return isLoading != null && isLoading
                        ? CircularProgressIndicator()
                        : Container();
                  }),
              Text("Select below item to change title"),
              StreamBuilder<List<Item>>(
                  stream: listOfItems,
                  initialData: [],
                  builder: (context, snapshot) {
                    return Column(
                      children: snapshot.hasData
                          ? snapshot.data!
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        changeIsLoading(true);
                                        await Future.delayed(
                                            Duration(seconds: 2));
                                        changeIsLoading(false);
                                        changeTitle(e.NameAr + " " + e.NameEn);
                                      },
                                      child: Text(e.NameAr + " " + e.NameEn),
                                    ),
                                  ))
                              .toList()
                          : [],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
