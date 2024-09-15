import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylp/pages/constants.dart';
import 'package:ylp/provider/controller.dart';

import '../constants/containerconstants.dart';
import '../provider/routes.dart';
class Apptitle extends StatefulWidget {
  const Apptitle({Key? key}) : super(key: key);

  @override
  State<Apptitle> createState() => _ApptitleState();
}

class _ApptitleState extends State<Apptitle> {



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = 150.0;
    int crossAxisCount=0;
    if (screenWidth <= 400) {
      crossAxisCount = 3;
    }
    else if (screenWidth <= 600 && screenWidth<800) {
      crossAxisCount = (screenWidth / 200).floor();
    }
    else if(screenWidth >=600 && screenWidth<1000)
    {
      crossAxisCount = (screenWidth / 230).floor();

    }
    else
    {
      crossAxisCount = (screenWidth / itemWidth).floor();
    }
    return Consumer<AppProvider>(builder: (BuildContext context, AppProvider value, Widget? child) {

      return Scaffold(
        appBar: AppBar(title: Text('LIST OF ARTICLES')),
        body: FutureBuilder<List<dynamic>?>(
          future: value.fetchData(),  // Call the updated fetchData function
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Please Wait...",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));//const Center(child: CircularProgressIndicator());  // Show loading spinner
            } else if (snapshot.hasError) {
              return const Center(child: Text('Check Internet Connection',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),));
            } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
              return  Center(child: Text('No data available'));
            } else {
              var data = snapshot.data!;  // The fetched list of data
              return GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,  // Number of items per row
                  crossAxisSpacing: 10.0,  // Spacing between columns
                  mainAxisSpacing: 10.0,  // Spacing between rows
                  childAspectRatio: 0.8,  // Aspect ratio of the items (height/width)
                ),
                padding: const EdgeInsets.all(10.0),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var item = data[index];  // Each item in the list
                  return InkWell(
                    onTap: ()async{
                      await value.setartitcie(item['catID'],item['title'],);
                      value.fetchDataArticle();
                      Navigator.pushNamed(context, Routes.html_data);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Constants.loginTextColor,  // Example color for container
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20.0),
                          const Icon(Icons.library_books, size: 40.0, color: Colors.white),
                          //Text(item['title'][0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.white),),
                          const SizedBox(height: 10.0),
                          Text(
                            item['title'] ?? 'No title',
                            style: const TextStyle(fontSize: 12.0, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    },);
  }
}
