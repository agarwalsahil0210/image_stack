import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List data = [];
  List<String> imgurls = [];
  List<String> description = [];
  bool showimg = false;

  getData() async {
    http.Response response = await http.get(
        'https://api.unsplash.com/collections/139386/photos/?client_id=YAD79ef-jaDaVgjLmHlTeJQGFde7UZIJd-gpY0hx0sE');
    data = json.decode(response.body);
    assign();
    setState(() {
      showimg = true;
    });
  }

  assign() {
    for (var i = 0; i < data.length; i++) {
      imgurls.add(data.elementAt(i)["urls"]["regular"]);
      !(data.elementAt(i)["description"] == null)
          ? description.add(data.elementAt(i)["description"])
          : description.add(data.elementAt(i)["alt_description"]);
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
                    : Column(
                  children: <Widget>[
                    Image(
                      image: NetworkImage(imgurls.elementAt(index)),
                      height: 150.0,
                      width: 200.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      child: !(description.elementAt(index) == null)?
                      Text(description.elementAt(index)):
                      Text("No Desciption"),
                    )
                  ],
                ));
          }),

    ));
  }
}
