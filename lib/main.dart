import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyPage());

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rest API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Rest API FormData",
            ),
          ),
        ),
        body: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic apiData;
  bool apiCalled = false;

  formData() async {
    final uri = 'https://httpbin.org/post';
    var data = {
      'name': 'user',
      'email_id': 'user123@mail.com',
      'password': 'user123',
    };

    http.Response response = await http.post(
      uri,
      body: json.encode(data),
    );

    print(response.body);

    if (response.statusCode == 200) {
      // return jsonEncode(response.body);
      apiData = jsonDecode(response.body);
      apiCalled = true;
      setState(() {});
    } else {
      throw Exception("Failed to create album.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding:  EdgeInsets.only(top:100.0),
                child: RaisedButton(
                  child: Text('Click Here'),
                  onPressed: () {
                    formData();
                  },
                ),
              ),
            ),
            apiCalled == true ? Text(apiData['json']['name'].toString()) : Container(),
            apiCalled == true ? Text(apiData['json']['email_id'].toString()) : Container(),
            apiCalled == true ? Text(apiData['json']['password'].toString()) : Container(),
          ],
        ),
      ),
    );
  }
}

