import 'package:flutter/material.dart';
class MyQuotes extends StatelessWidget {
  final List<String> videoUrls;

  const MyQuotes({super.key, required this.videoUrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1, // Adjust grid based on screen width
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 16 / 9, // Aspect ratio for the video tiles
        ),
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          //return VideoTile(videoUrl: videoUrls[index]);
        },
      ),
    );
  }
}
