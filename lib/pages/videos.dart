import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Videos extends StatelessWidget {
  final List<String> videoUrls;

  const Videos({super.key, required this.videoUrls});

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    // Define the width of each grid item based on screen size
    double itemWidth = screenWidth > 600 ? 300.0 : screenWidth * 0.45;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,  // Space between items horizontally
            runSpacing: 10,  // Space between items vertically
            children: videoUrls.map((videoUrl) {
              return SizedBox(
                width: itemWidth,  // Make each item a fixed width
                child: VideoTile(videoUrl: videoUrl),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class VideoTile extends StatefulWidget {
  final String videoUrl;

  const VideoTile({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        playsInline: false,
        enableCaption: true,
        showFullscreenButton: true,
      ),
    );
    _loadVideo(widget.videoUrl);
  }

  String? getYouTubeVideoId(String url) {
    Uri uri = Uri.parse(url);
    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'];
    }
    return null;
  }

  void _loadVideo(String videoUrl) {
    String? videoId = getYouTubeVideoId(videoUrl);
    if (videoId != null) {
      _controller.loadVideoById(videoId: videoId);
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: YoutubePlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              )
            ),
            child: Text(
              "TITLE",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
