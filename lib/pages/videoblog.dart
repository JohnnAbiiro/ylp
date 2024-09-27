import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class VideoBlog extends StatefulWidget {
  const VideoBlog({super.key});

  @override
  State<VideoBlog> createState() => _VideoBlogState();
}

class _VideoBlogState extends State<VideoBlog> {
  List<Map<String, String>> videos = [];

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      List<Map<String, String>> videoData = await fetchVideoUrlsAndTitles();
      setState(() {
        videos = videoData;
      });
    } catch (error) {
      setState(() {
        videos = [];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: videos.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                    MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 16 / 9,
                  ),
              itemCount: videos.length,
              itemBuilder: (context, index) {
            return VideoTile(
              videoUrl: videos[index]['url']!,
              videoTitle: videos[index]['title']!,
            );
          },
        ),
      ),
    );
  }
}

Future<List<Map<String, String>>> fetchVideoUrlsAndTitles() async {
  await Future.delayed(const Duration(seconds: 4));

  return [
    {
      "url": "https://www.youtube.com/watch?v=-bUuQ4_XoZ8&t=195s",
      "title": "Empowering Women Entrepreneurs in Ghana",
    },
    {
      "url": "https://www.youtube.com/watch?v=kU-pqiLHD8s&t=40s",
      "title": "The Future of Technology in Africa",
    },
    {
      "url": "https://www.youtube.com/watch?v=kU-pqiLHD8s&t=40s",
      "title": "The Future of Technology in Africa",
    },
    {
      "url": "https://www.youtube.com/watch?v=kU-pqiLHD8s&t=40s",
      "title": "The Future of Technology in Africa",
    },
    {
      "url": "https://www.youtube.com/watch?v=kU-pqiLHD8s&t=40s",
      "title": "The Future of Technology in Africa",
    },
  ];
}

class VideoTile extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;

  const VideoTile({Key? key, required this.videoUrl, required this.videoTitle})
      : super(key: key);

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
            ),
            const SizedBox(height: 8),
            // show video title
            Text(
              widget.videoTitle, 
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
