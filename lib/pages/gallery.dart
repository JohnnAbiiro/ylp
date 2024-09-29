import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class PhotoGalleryApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhotoGalleryScreen(),
    );
  }
}

class PhotoGalleryScreen extends StatefulWidget {
  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  // List of image URLs
  final List<String> _imageUrls = [
    'https://firebasestorage.googleapis.com/v0/b/africanstraw-e03e1.appspot.com/o/null1727453332908.jpg?alt=media&token=1054c0da-a0f8-4849-9d05-71c52ea45493',
    'https://firebasestorage.googleapis.com/v0/b/africanstraw-e03e1.appspot.com/o/null1727453332908.jpg?alt=media&token=1054c0da-a0f8-4849-9d05-71c52ea45493',
    'https://firebasestorage.googleapis.com/v0/b/africanstraw-e03e1.appspot.com/o/null1727453332908.jpg?alt=media&token=1054c0da-a0f8-4849-9d05-71c52ea45493',
    'https://firebasestorage.googleapis.com/v0/b/africanstraw-e03e1.appspot.com/o/null1727453332908.jpg?alt=media&token=1054c0da-a0f8-4849-9d05-71c52ea45493',
    'https://firebasestorage.googleapis.com/v0/b/africanstraw-e03e1.appspot.com/o/null1727453332908.jpg?alt=media&token=1054c0da-a0f8-4849-9d05-71c52ea45493',
    'https://firebasestorage.googleapis.com/v0/b/africanstraw-e03e1.appspot.com/o/null1727453332908.jpg?alt=media&token=1054c0da-a0f8-4849-9d05-71c52ea45493',
    'https://firebasestorage.googleapis.com/v0/b/africanstraw-e03e1.appspot.com/o/null1727453332908.jpg?alt=media&token=1054c0da-a0f8-4849-9d05-71c52ea45493',
    'https://firebasestorage.googleapis.com/v0/b/africanstraw-e03e1.appspot.com/o/null1727453332908.jpg?alt=media&token=1054c0da-a0f8-4849-9d05-71c52ea45493',
    // Add more URLs
  ];

  // Method to view an image in full screen
  void _viewImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: PhotoView(
              semanticLabel: "Kolog John",
              enableRotation: true,
              imageProvider: NetworkImage(
                  imageUrl
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Gallery"),
      ),
      body: _imageUrls.isEmpty
          ? const Center(child: Text("No images available."))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of images per row
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _viewImage(context, _imageUrls[index]),
            child: Image.network(
              _imageUrls[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
