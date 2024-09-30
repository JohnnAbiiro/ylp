
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../constants/iconconstants.dart';

class PhotoAlbum extends StatefulWidget {
  @override
  _PhotoAlbumState createState() => _PhotoAlbumState();
}

class _PhotoAlbumState extends State<PhotoAlbum> {
  List<ImageDetail> images = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      images = [
        ImageDetail(
          imageUrl: 'https://ylpghana.com/wp-content/uploads/2022/10/Untitled-1.jpg',
          title: 'Image 1',
          description: 'Description for Image 1',
        ),
        ImageDetail(
          imageUrl: 'https://ylpghana.com/wp-content/uploads/2022/10/202.jpg',
          title: 'Image 2',
          description: 'Description for Image 2',
        ),
        ImageDetail(
          imageUrl: 'https://ylpghana.com/wp-content/uploads/2022/10/97.jpg',
          title: 'Image 3',
          description: 'Description for Image 3',
        ),
        ImageDetail(
          imageUrl: 'https://ylpghana.com/wp-content/uploads/2022/10/ttrrr.jpg',
          title: 'Image 4',
          description: 'Description for Image 4',
        ),
        ImageDetail(
          imageUrl: 'https://ylpghana.com/wp-content/uploads/2022/10/760.jpg',
          title: 'Image 5',
          description: 'Description for Image 5',
        ),
        ImageDetail(
          imageUrl: 'https://ylpghana.com/wp-content/uploads/2022/10/49.jpg',
          title: 'Image 6',
          description: 'Description for Image 6',
        ),
        ImageDetail(
          imageUrl: 'https://ylpghana.com/wp-content/uploads/2022/10/154.jpg',
          title: 'Image 7',
          description: 'Description for Image 7',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Album', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF72024A),
        iconTheme: const IconThemeData(color: ConstantsIcon.iconWhite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: images.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(
                      images: images,
                      initialIndex: index,
                    ),
                  ),
                );
              },
              child: ImageCard(imageUrl: images[index].imageUrl),
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
  final List<ImageDetail> images;
  final int initialIndex;

  const FullScreenImage({
    super.key,
    required this.images,
    required this.initialIndex,
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
  }

  void autoScrollImages() {
    if (isPlaying) {
      Future.delayed(const Duration(seconds: 3), () {
        if (!isPlaying) return; // Stop autoplay if isPlaying is false
        setState(() {
          currentIndex = (currentIndex + 1) % widget.images.length; // Loop back to the first image
          transformationController.value = Matrix4.identity(); // Reset zoom on each change
        });
        autoScrollImages(); // Recursive call to keep the slideshow playing
      });
    }
  }

  void nextImage() {
    if (currentIndex < widget.images.length - 1) {
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
    if (details.velocity.pixelsPerSecond.dx > 0) {
      previousImage(); // Swipe right to go to previous image
    } else if (details.velocity.pixelsPerSecond.dx < 0) {
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
                widget.images[currentIndex].title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.images[currentIndex].description,
                style: const TextStyle(fontSize: 14),
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
        iconTheme: const IconThemeData(color: ConstantsIcon.iconWhite),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onDoubleTap: onDoubleTap,
              onHorizontalDragEnd: onSwipe,
              onTap: showImageDetails, // Show details on tap
              child: InteractiveViewer(
                transformationController: transformationController,
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4.0,
                child: CachedNetworkImage(
                  imageUrl: widget.images[currentIndex].imageUrl,
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
            onZoomIn: () => setState(() {
              currentScale += 0.5;
              transformationController.value = Matrix4.identity()..scale(currentScale);
            }),
            onZoomOut: () => setState(() {
              if (currentScale > 1.0) {
                currentScale -= 0.5;
                transformationController.value = Matrix4.identity()..scale(currentScale);
              }
            }),
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
      padding: const EdgeInsets.all(8.0),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onPrevious,
          ),
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: onTogglePlayPause,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in, color: Colors.white),
            onPressed: onZoomIn,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out, color: Colors.white),
            onPressed: onZoomOut,
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

class ImageDetail {
  final String imageUrl;
  final String title;
  final String description;

  ImageDetail({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

