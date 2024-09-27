import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class VideoBlog extends StatefulWidget {
  const VideoBlog({super.key});

  @override
  State<VideoBlog> createState() => _VideoBlogState();
}

class _VideoBlogState extends State<VideoBlog> {
  List<String> videoUrls = []; 

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  
  Future<void> _loadVideos() async {
    List<String> urls = await fetchVideoUrls();
    setState(() {
      videoUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: videoUrls.isEmpty
            ? const Center(child: Text("Loading...please wait")) 
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            MediaQuery.of(context).size.width > 600 ? 2 : 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 16 / 9,
          ),
          itemCount: videoUrls.length,
          itemBuilder: (context, index) {
            return VideoTile(videoUrl: videoUrls[index]);
          },
        ),
      ),
    );
  }
}

Future<List<String>> fetchVideoUrls() async {
  await Future.delayed(const Duration(seconds: 4));

  return [
    "https://www.youtube.com/watch?v=fGoFE3DS6sk",
    "https://www.youtube.com/watch?v=MJ5HksruKgE",
  ];
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
        showFullscreenButton: true,
      ),
    );
    _loadVideo(widget.videoUrl);
  }

  
  String? _getYouTubeVideoId(String url) {
    Uri uri = Uri.parse(url);
    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'];
    }
    return null;
  }
  
  void _loadVideo(String videoUrl) {
    String? videoId = _getYouTubeVideoId(videoUrl);
    if (videoId != null) {
      _controller.cueVideoById(videoId: videoId);
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
            ),
            const SizedBox(height: 8),
            const Text(
              "Learn about empowering women entrepreneurs in Ghana.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
