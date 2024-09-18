import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylp/provider/controller.dart';
import '../provider/routes.dart';
import 'constants.dart';
import '../constants/containerconstants.dart';
import '../constants/imageconstants.dart';
import '../constants/textconstants.dart';
import '../constants/iconconstants.dart';
class Article_category extends StatefulWidget {
  const Article_category({super.key});

  @override
  _Article_categoryState createState() => _Article_categoryState();
}

class _Article_categoryState extends State<Article_category> {
  // final List<Map<String, String>> _events = [
  //   {
  //     'title': 'Youth Empowerment Summit',
  //     'description': 'A summit focused on empowering the youth with skills and leadership training.',
  //     'date': 'March 22, 2024',
  //     'location': 'Accra, Ghana',
  //   },
  //   {
  //     'title': 'Policy Development Workshop',
  //     'description': 'Join policymakers and civic leaders in discussing the future of education policy.',
  //     'date': 'April 5, 2024',
  //     'location': 'Kumasi, Ghana',
  //   },
  //   {
  //     'title': 'Community Health Fair',
  //     'description': 'Free health services and education provided by local healthcare professionals.',
  //     'date': 'May 10, 2024',
  //     'location': 'Tamale, Ghana',
  //   },
  // ];

  String _searchQuery = "";
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider value, Widget? child) {
        if(value.auth.currentUser==null){
          value.logout(context);
        }
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(onTap:(){
              Navigator.pushNamed(context, Routes.dashboard);
            },child: const Icon(Icons.arrow_back,color: Colors.white,)),
            title: _isSearching
                ? TextFormField(
              autofocus: true,
              decoration:  InputDecoration(
                hintText: '${value.articletitle} Events...',
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            )
                :  Text('${value.articletitle}',style: TextStyle(color: ConstantsTextColor.logintext,fontSize: 12.0),),
            backgroundColor: ContainerConstants.appBarColor,
            iconTheme: const IconThemeData(
              color: ConstantsIcon.iconWhite,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    if (_isSearching) {
                      _searchQuery = '';
                    }
                    _isSearching = !_isSearching;
                  });
                },
              ),
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Center(
                    //   child:  Text(value.articletitle,
                    //     style: TextStyle(
                    //       fontSize: 12.0,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20.0),

                    // Event List
                    Expanded(
                      child:  FutureBuilder<List<dynamic>?>(
                        future: value.fetchDataArticle(),  // Call the updated fetchData function
                        builder: (context, snapshot) {

                          if(!snapshot.hasData){
                            return Text("No data");
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var item=snapshot.data![index];
                              String title=item['title']!;
                              String des=item['article'];
                              int id=int.parse(item['id']);

                             // final event = _filteredEvents[index];
                              return Card(
                                color: ContainerConstants.appBarColor,
                                elevation: 4.0,
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16.0),
                                  title: Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600,color: Colors.white)),
                                  subtitle: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8.0),
                                      Text("Short Description",style: TextStyle(color: Colors.white),),
                                      SizedBox(height: 8.0),
                                      Text('Date: 19/01/2020',style: TextStyle(fontSize: 12.0,color: Colors.white),),
                                      Text('Location: "location"',style: TextStyle(fontSize: 12.0,color: Colors.white),),
                                    ],
                                  ),
                                  trailing: const Icon(Icons.event,color: Colors.white,),
                                  onTap: () async{
                                    value.setarticle(value.articleval, title);
                                    value.setarticle_specifi(id);
                                    value.getarticle();
                                   // value.fetchDataArticle_specific();
                                    Navigator.pushNamed(context, Routes.html_data);
                                  },
                                ),
                              );
                              //   _buildEventItem(
                              //   title: title,
                              //   description:"${des}...",
                              //   date: "date",
                              //   location: "",
                              // );
                            },
                          );

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

      },
    );
  }


  _buildEventItem({
    required String title,
    required String description,
    required String date,
    required String location,
  }) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text(description),
            const SizedBox(height: 8.0),
            Text('Date: $date',style: const TextStyle(fontSize: 12.0),),
            Text('Location: $location',style: const TextStyle(fontSize: 12.0),),
          ],
        ),
        trailing: const Icon(Icons.event),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventDetailPage(
              title: title,
              description: description,
              date: date,
              location: location,
            ),
          ));
        },
      ),
    );
  }
}


class EventDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String location;

  EventDetailPage({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details',style: TextStyle(color: ConstantsTextColor.logintext,fontSize: 12.0,),
        ),
        backgroundColor: ContainerConstants.appBarColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: ConstantsIcon.iconWhite
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Date: $date',
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Location: $location',
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
