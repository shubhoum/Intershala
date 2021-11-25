import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String apiLink =
      "https://run.mocky.io/v3/f3feef1c-9bfa-43fd-b2a0-bbe9abadb4f6";
  dynamic data;

  Future<bool> getAPIResponse() async {
    Response response = await get(Uri.parse(apiLink));
    var temp = await json.decode(response.body);
    data = temp["clients"];

    if (data != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Internshala"),
      ),
      body: FutureBuilder(
        future: getAPIResponse(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name = ${data[index]["name"]}'),
                            Text('Company = ${data[index]["company"]}'),
                          ],
                        ),
                      ),
                    );
                  })
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
