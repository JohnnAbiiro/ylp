import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../constants/containerconstants.dart';

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
    // Desired width for each tile
    const double tileWidth = 200.0;
    final int crossAxisCount = (MediaQuery.of(context).size.width / tileWidth).floor();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: videos.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:crossAxisCount,
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
      "url": "https://www.youtube.com/watch?v=fGoFE3DS6sk",
      "title": "Empowering Women Entrepreneurs in Ghana Empowering Women Entrepreneurs in Ghana Empowering Women Entrepreneurs in Ghana",
    },
    {
      "url": "https://www.youtube.com/watch?v=MJ5HksruKgE",
      "title": "The Future of Technology in Africa",
    },
    {
      "url": "https://www.youtube.com/watch?v=fGoFE3DS6sk",
      "title": "Empowering Women Entrepreneurs in Ghana",
    },
    {
      "url": "https://www.youtube.com/watch?v=fGoFE3DS6sk",
      "title": "Empowering Women Entrepreneurs in Ghana",
    },
    {
      "url": "https://www.youtube.com/watch?v=MJ5HksruKgE",
      "title": "The Future of Technology in Africa",
    },
    {
      "url": "https://www.youtube.com/watch?v=MJ5HksruKgE",
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double textSize = screenWidth < 400 ? 12 : 14;

        return Container(
          margin: const EdgeInsets.all(10),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Video player with flex behavior
              Expanded(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: screenWidth > 600 ? 16 / 9 : 4 / 3,
                  child: YoutubePlayer(
                    controller: _controller,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ContainerConstants.loginContainer,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Text(
                        widget.videoTitle,
                        style: TextStyle(
                          fontSize: textSize,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
