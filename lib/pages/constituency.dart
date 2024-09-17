import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylp/constants/containerconstants.dart';
import 'package:ylp/provider/controller.dart';

import '../provider/routes.dart';
import 'constants.dart';

class Constituency extends StatelessWidget {
  const Constituency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = 400.0;
    int crossAxisCount=0;
    if (screenWidth <= 400) {
      crossAxisCount = 2;
    }
    else if (screenWidth <= 600 && screenWidth<800) {
      crossAxisCount = (screenWidth / 200).floor();
    }
    else if(screenWidth >=600 && screenWidth<1000)
    {
      crossAxisCount = (screenWidth / 200).floor();

    }
    else
    {
      crossAxisCount = (screenWidth / itemWidth).floor();
    }
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider value, Widget? child) {
        if(value.auth.currentUser==null){
          value.logout(context);
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ContainerConstants.appBarColor,
            leading: InkWell(onTap:(){
              Navigator.pushNamed(context, Routes.regions);
            },child: Icon(Icons.arrow_back,color: Colors.white,)),
            title: Text(value.regionname,style: TextStyle(color: Colors.white),),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: value.constituencydata(),
                builder: (BuildContext context, snapshot) {
                  if(!snapshot.hasData){
                    return Text("No Data");
                  }
                  else if(snapshot.hasError){
                    return Text("Error: ${snapshot.error}");
                  }
                  else if(snapshot.connectionState==ConnectionState.waiting){
                    return Text("Please Wait");
                  }
                  return  GridView.builder(
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:crossAxisCount ,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        var data=snapshot.data![index];
                        var name=data['constituencyName'];
                        var code=data['constituencyCode'];
                        var pscount=data['pollstCount'];
                        print(snapshot);

                        return InkWell(
                          onTap: (){
                            //Navigator.pushNamed(context, routeName)
                          },
                          child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Constants.loginTextColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(child: Center(child: Text(name, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),))),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 2,
                                            width: 50,
                                            color: Colors.white54,
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("#PS:", style: TextStyle(color: Colors.white, fontSize: 18),),
                                          SizedBox(width: 6),
                                          Text("$pscount", style: TextStyle(color: Colors.white, fontSize: 18),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ),
                        );
                      }
                  );

                },
              )
          ),
        );

      },
    );
  }
}
