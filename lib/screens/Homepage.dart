import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var mapResponse;
  var listresponse;
  var dataresponse;
  var userid;
  var image;
  var width;
  var height;
  var isdataloading = false;
  var responseBody;

  Future apiget() async {
    setState(() {
      isdataloading = true;
    });
    http.Response response;
    response =
        await http.get(Uri.parse("https://api.thecatapi.com/v1/images/search"));
    if (response.statusCode == 200) {
      responseBody = response.body;
      // print(mapResponse[0]['id']);
      setState(() {
        mapResponse = jsonDecode(response.body);
        userid = mapResponse[0]['id'];
        image = mapResponse[0]['url'];
        height = mapResponse[0]['height'];
        width = mapResponse[0]['width'];
        isdataloading = false;
      });
      print(mapResponse.length);
      // print(response.body.toString());
      // setState(() {
      // mapResponse = jsonDecode(response.body);
      //   dataresponse = mapResponse[''];
      // });
    }
  }

  @override
  void initState() {
    apiget();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api "),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(onTap: apiget, child: Icon(Icons.refresh)),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                isdataloading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 5),
                            top: BorderSide(color: Colors.black, width: 5),
                            right: BorderSide(color: Colors.black, width: 5),
                            left: BorderSide(color: Colors.black, width: 5),
                          ),
                        ),
                        child: Image.network(
                          image,
                          fit: BoxFit.fill,
                          height: 100,
                          width: 100,
                        ),
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID : $userid",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Width : $width",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Height : $height",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          );
        },
        itemCount: mapResponse == null ? 0 : mapResponse.length,
      ),
    );
  }
}
