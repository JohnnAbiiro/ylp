import 'package:flutter/material.dart';

class PhotoAlbum extends StatefulWidget {
  @override
  _PhotoAlbumState createState() => _PhotoAlbumState();
}

class _PhotoAlbumState extends State<PhotoAlbum> {
  List<String> imageUrls = [];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      imageUrls = [
        'https://ylpghana.com/wp-content/uploads/2022/10/Untitled-1.jpg',
        'https://placekitten.com/g/200/300',
      ];
    });
  }

  void nextImage() {
    if (currentIndex < imageUrls.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void previousImage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Photo Album',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF72024A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: imageUrls.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Expanded(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 1.0,
                maxScale: 4.0,
                child: Image.network(
                  imageUrls[currentIndex],
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: previousImage,
                  color: currentIndex > 0 ? Colors.black : Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: nextImage,
                  color: currentIndex < imageUrls.length - 1
                      ? Colors.black
                      : Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
