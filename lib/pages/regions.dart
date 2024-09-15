import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylp/provider/controller.dart';

import '../provider/routes.dart';
import 'constants.dart';

class RegionList extends StatelessWidget {
  const RegionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider value, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Regions"),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: value.regions(),
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
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        var data=snapshot.data![index];
                        String regionname=data['regionName'];
                        String code=data['regionCode'];
                        return InkWell(
                          onTap: ()async{
                            value.setregion(regionname, code);
                            Navigator.pushNamed(context, Routes.constituency);
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
                                          Expanded(child: Center(child: Text(regionname, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),))),
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
                                          Text("Constituency:", style: TextStyle(color: Colors.white, fontSize: 18),),
                                          SizedBox(width: 6),
                                          Text(code, style: TextStyle(color: Colors.white, fontSize: 18),),
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
