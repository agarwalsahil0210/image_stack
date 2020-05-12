import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List data = [];
  List<String> imgurls = [];
  bool showimg = false;

  getData() async {
    http.Response response = await http.get(
        'https://api.unsplash.com/collections/1580860/photos/?client_id=YAD79ef-jaDaVgjLmHlTeJQGFde7UZIJd-gpY0hx0sE');
    data = json.decode(response.body);
    assign();
    setState(() {
      showimg = true;
    });
  }

  assign() {
    for (var i = 0; i < data.length; i++) {
      imgurls.add(data.elementAt(i)["urls"]["regular"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(data.length, (index) {
          return Center(
            child: !showimg
                ? CircularProgressIndicator()
                : Image(
                    image: NetworkImage(imgurls.elementAt(index)),
                    height: 150.0,
                    width: 200.0,
                    fit: BoxFit.cover,
                  ),
          );
        }),
      ),
    );
  }
}
