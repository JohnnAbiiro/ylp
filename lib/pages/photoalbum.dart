import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoAlbum extends StatefulWidget {
  @override
  _PhotoAlbumState createState() => _PhotoAlbumState();
}

class _PhotoAlbumState extends State<PhotoAlbum> {
  List<String> imageUrls = [];
  List<String> titles = [];
  List<String> descriptions = [];

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
        'https://ylpghana.com/wp-content/uploads/2022/10/202.jpg',
        'https://ylpghana.com/wp-content/uploads/2022/10/97.jpg',
        'https://ylpghana.com/wp-content/uploads/2022/10/ttrrr.jpg',
        'https://ylpghana.com/wp-content/uploads/2022/10/760.jpg',
        'https://ylpghana.com/wp-content/uploads/2022/10/49.jpg',
        'https://ylpghana.com/wp-content/uploads/2022/10/154.jpg',
      ];
      titles = [
        'Image 1',
        'Image 2',
        'Image 3',
        'Image 4',
        'Image 5',
        'Image 6',
        'Image 7',
      ];
      descriptions = [
        'Description for Image 1',
        'Description for Image 2',
        'Description for Image 3',
        'Description for Image 4',
        'Description for Image 5',
        'Description for Image 6',
        'Description for Image 7',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Album', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF72024A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: imageUrls.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(
                      imageUrls: imageUrls,
                      initialIndex: index,
                      isPlaying: false,
                      title: titles[index],
                      description: descriptions[index],
                    ),
                  ),
                );
              },
              child: ImageCard(imageUrl: imageUrls[index]),
            );
          },
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imageUrl;
  const ImageCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final bool isPlaying;
  final String title;
  final String description;

  const FullScreenImage({
    super.key,
    required this.imageUrls,
    required this.isPlaying,
    required this.initialIndex,
    required this.title,
    required this.description,
  });

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late int currentIndex;
  late bool isPlaying;
  late double currentScale;
  late TransformationController transformationController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    isPlaying = false;
    currentScale = 1.0;
    transformationController = TransformationController();
    autoScrollImages();
  }

  void autoScrollImages() {
    if (isPlaying) {
      Future.delayed(const Duration(seconds: 3), () {
        if (!isPlaying) return; // Stop autoplay if isPlaying is false
        setState(() {
          currentIndex = (currentIndex + 1) % widget.imageUrls.length; // Loop back to the first image
          transformationController.value = Matrix4.identity(); // Reset zoom on each change
        });
        autoScrollImages(); // Recursive call to keep the slideshow playing
      });
    }
  }

  void nextImage() {
    if (currentIndex < widget.imageUrls.length - 1) {
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
      previousImage(); // Swipe right to go to previous image
    } else if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
      nextImage(); // Swipe left to go to next image
    }
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying; // Toggle between playing and pausing
    });
    if (isPlaying) {
      autoScrollImages(); // Start autoplay when isPlaying is true
    }
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
        currentScale = 2.0; // Zoom in
      } else {
        currentScale = 1.0; // Reset zoom
      }
      transformationController.value = Matrix4.identity()..scale(currentScale);
    });
  }

  void showImageDetails() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF72024A),
        title: const Text('Photo', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            child: /*GestureDetector(
              onDoubleTap: onDoubleTap,
              onPanEnd: onSwipe,
              onTap: showImageDetails, // Show details on tap
              child: InteractiveViewer(
                transformationController: transformationController,
                panEnabled: true, // Allow panning
                minScale: 0.5,
                maxScale: 4.0, // Controls the zoom level
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrls[currentIndex],
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),*/
        GestureDetector(
      onDoubleTap: onDoubleTap,
        onPanEnd: onSwipe,
        onPanUpdate: (details) {
          if (details.delta.dx < 0) {
            // Swipe left to go to the next image
            nextImage();
          } else if (details.delta.dx > 0) {
            // Swipe right to go to the previous image
            previousImage();
          }
        },
        onTap: showImageDetails, // Show details on tap
        child: InteractiveViewer(
          transformationController: transformationController,
          panEnabled: true, // Allow panning
          minScale: 0.5,
          maxScale: 4.0, // Controls the zoom level
          child: CachedNetworkImage(
            imageUrl: widget.imageUrls[currentIndex],
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
          ),
          ControlPanel(
            onNext: nextImage,
            onPrevious: previousImage,
            onTogglePlayPause: togglePlayPause,
            onZoomIn: zoomIn,
            onZoomOut: zoomOut,
            isPlaying: isPlaying,
          ),
        ],
      ),
    );
  }
}

class ControlPanel extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onTogglePlayPause;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final bool isPlaying;

  const ControlPanel({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.onTogglePlayPause,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF72024A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.zoom_out, color: Colors.white),
            onPressed: onZoomOut,
          ),
          IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
            onPressed: onTogglePlayPause,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in, color: Colors.white),
            onPressed: onZoomIn,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onPrevious,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
