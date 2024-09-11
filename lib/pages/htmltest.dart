import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:ylp/provider/controller.dart';
class Htmlapi extends StatefulWidget {
  @override
  _HtmlapiState createState() => _HtmlapiState();
}

class _HtmlapiState extends State<Htmlapi> {

  @override
  void initState() {
    super.initState();
    //fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return  Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider value, Widget? child) {
        value.fetchDataArticle();
        return Scaffold(
          appBar: AppBar(
            title: const Text('HISTORY OF GHANA'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Card(
                child: HtmlWidget(
                  value.htmlData,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
