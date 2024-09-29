import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:ylp/provider/controller.dart';
import '../constants/containerconstants.dart';
import '../constants/imageconstants.dart';

class LandingPage extends StatelessWidget {
  final List<String> carouselImages = [
    ConstantsImage.bg1,
    ConstantsImage.background,
    ConstantsImage.bg2,
    ConstantsImage.bg3,
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider value, Widget? child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Image carousel
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                  ),
                  items: carouselImages.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            Image.asset(
                              imagePath,
                              width: screenWidth,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 100,
                              left: 20,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Welcome to Youth Parliament!",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Engage. Learn. Lead.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Navigate to main feature of the app
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ContainerConstants.appBarColor,
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        ),
                                        child: Text("Read More",style: TextStyle(color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),

                SizedBox(height: 10),

                // Introduction or mission statement
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Join the movement of empowered youth shaping the future of leadership and politics. "
                        "Get trained, participate in polls, and voice your opinions on matters that matter!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upcoming Events",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(

                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return _buildEventCard(context, "Event $index", "October 10, 2024");
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Recent Articles Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Articles",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      FutureBuilder(
                        future:value.recent_articles(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          //print(snapshot.data);
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final data=snapshot.data[index];
                            return _buildArticleCard(context, data['title'],data['shortDesc']);
                            },
                          );

                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureTile(BuildContext context, String imagePath, String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
        )
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 80,
            height: 80,
          ),
          SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, String title, String date) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          ContainerConstants.appBarColor,
          ContainerConstants.containerBackgroundColor,

        ]),
        color: ContainerConstants.appBarColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              date,
              style: TextStyle(fontSize: 14,color: Colors.white),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to event details
              },
              child: Text("Learn More",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                backgroundColor: ContainerConstants.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, String title,String shortDesc) {
    return Card(
      color: ContainerConstants.appBarColor,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title,style: TextStyle(color: Colors.white),),
        subtitle:  Text(shortDesc,style: TextStyle(color: Colors.white),),
        trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
        onTap: () {
          // Navigate to article details
        },
      ),
    );
  }
}
