import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:ylp/pages/constants.dart';
import 'package:ylp/provider/controller.dart';

import '../provider/routes.dart';
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
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: (){
                Navigator.pushNamed(context, Routes.article_category);
              },
                child: Icon(Icons.arrow_back,color: Colors.white,)
            ),
            backgroundColor: Constants.loginTextColor,
            title:  Text(value.articletitle,style: TextStyle(color: Colors.white),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: value.FuturefetchDataArticle_specific(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasError){
                      return const Center(child: Text("Error!!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
                    }
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const Center(child: Text("Please wait..",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
                    }
                    if(!snapshot.hasData){
                      return const Center(child: Text("Please Wait...",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
                    }
                    return HtmlWidget(
                      snapshot.data,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
