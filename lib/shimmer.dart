import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'constants/containerconstants.dart';

class ShimmerDurationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: ContainerConstants.appBarColor!,
          highlightColor: Colors.grey[100]!,
          period: const Duration(seconds: 2),  // Setting the shimmer duration
          child:GridView.builder(
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items per row
              crossAxisSpacing: 10.0, // Space between items horizontally
              mainAxisSpacing: 10.0, // Space between items vertically
            ),
            itemCount: 6, // Number of grid items
            itemBuilder: (context, index) {
              String shortname="";
              String id="";
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: ContainerConstants.pollOptionsContainer,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.0),
                    Icon(Icons.school, size: 40.0, color: Colors.white),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: Text(
                        "Loading",
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              );
            },
          ),
          // ListView.builder(
          //   itemCount: 6,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding: const EdgeInsets.only(bottom: 8.0),
          //       child: Container(
          //         height: 100.0,
          //         color: Colors.grey[300],
          //       ),
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}

