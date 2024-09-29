import 'package:flutter/material.dart';

class PhotoAlbum extends StatefulWidget {
  @override
  _PhotoAlbumState createState() => _PhotoAlbumState();
}

class _PhotoAlbumState extends State<PhotoAlbum> {
  List<String> imagePaths = [];
  int currentIndex = 0;
  bool isPlaying = true;
  double currentScale = 1.0;
  TransformationController transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    fetchImages();
    autoScrollImages();
  }

  @override
  void dispose() {
    transformationController.dispose();
    super.dispose();
  }

  Future<void> fetchImages() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      imagePaths = [
        'images/6.jpg',
        'images/32.jpg',
        'images/154.jpg',
        'images/97.jpg',
        'images/49.jpg',
        'images/760.jpg',
        'images/623.jpg',
      ];
    });
  }

  void autoScrollImages() {
    Future.delayed(Duration(seconds: 3), () {
      if (isPlaying && currentIndex < imagePaths.length - 1) {
        nextImage();
      }
      if (isPlaying) {
        autoScrollImages();
      }
    });
  }

  void nextImage() {
    if (currentIndex < imagePaths.length - 1) {
      setState(() {
        currentIndex++;
        transformationController.value = Matrix4.identity(); // Reset zoom
      });
    }
  }

  void previousImage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        transformationController.value = Matrix4.identity(); // Reset zoom
      });
    }
  }

  void onSwipe(DragEndDetails details) {
    if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
      previousImage();  // Swipe right to go to previous image
    } else if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
      nextImage();  // Swipe left to go to next image
    }
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void zoomIn() {
    setState(() {
      currentScale += 0.5;
      transformationController.value = Matrix4.identity()..scale(currentScale);
    });
  }

  void zoomOut() {
    setState(() {
      if (currentScale > 1.0) {
        currentScale -= 0.5;
        transformationController.value = Matrix4.identity()..scale(currentScale);
      }
    });
  }

  void onDoubleTap() {
    setState(() {
      if (currentScale == 1.0) {
        currentScale = 2.0;  // Zoom in
      } else {
        currentScale = 1.0;  // Reset zoom
      }
      transformationController.value = Matrix4.identity()..scale(currentScale);
    });
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
        child: imagePaths.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: onSwipe,  // Detect swipes
                onDoubleTap: onDoubleTap,  // Double-tap to zoom (mobile)
                child: MouseRegion(
                  onEnter: (_) => setState(() => currentScale = 2.0),  // Zoom on hover (web)
                  onExit: (_) => setState(() => currentScale = 1.0),
                  child: InteractiveViewer(
                    panEnabled: true,
                    transformationController: transformationController,
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Image.asset(
                      imagePaths[currentIndex],
                      fit: BoxFit.contain,
                    ),
                  ),
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
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: togglePlayPause,
                  color: Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: nextImage,
                  color: currentIndex < imagePaths.length - 1
                      ? Colors.black
                      : Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.zoom_in),
                  onPressed: zoomIn,
                ),
                IconButton(
                  icon: const Icon(Icons.zoom_out),
                  onPressed: zoomOut,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
