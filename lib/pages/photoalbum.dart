import 'package:flutter/material.dart';


class PhotoAlbum extends StatefulWidget {
  @override
  _PhotoAlbumState createState() => _PhotoAlbumState();
}

class _PhotoAlbumState extends State<PhotoAlbum> {
  List<String> imageUrls = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Album',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF72024A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: imageUrls.isEmpty
            ? const Center(child: CircularProgressIndicator()) //
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return ImageCard(imageUrl: imageUrls[index]);
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
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}