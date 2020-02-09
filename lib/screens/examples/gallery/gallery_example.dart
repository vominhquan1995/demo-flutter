import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:demo_flutter/screens/app_bar.dart';
import 'package:demo_flutter/screens/examples/gallery/gallery_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'gallery_image.dart';

class GalleryExample extends StatefulWidget {
  @override
  _GalleryExampleState createState() => _GalleryExampleState();
}

class _GalleryExampleState extends State<GalleryExample> {
  List<GalleryItem> galleryItems = <GalleryItem>[
    GalleryItem(
        id: "tag1",
        resource: "assets/p1.jpg",
        thumnail: "assets/p1.jpg",
        isVideo: false),
    GalleryItem(
        id: "tag2",
        resource: "assets/p2.jpg",
        thumnail: 'assets/p2.jpg',
        isVideo: false),
    GalleryItem(
        id: "8",
        resource: "https://www.youtube.com/watch?v=stYz1_8Cb2A",
        thumnail: 'assets/play_video.png',
        isVideo: true),
    GalleryItem(
        id: "tag3",
        resource: "assets/p3.jpg",
        thumnail: "assets/p1.jpg",
        isVideo: false),
    GalleryItem(
        id: "tag4",
        resource: "assets/p4.jpg",
        thumnail: "assets/p1.jpg",
        isVideo: false),
    GalleryItem(
        id: "tag5",
        resource: "assets/p5.jpg",
        thumnail: "assets/p1.jpg",
        isVideo: false),
    GalleryItem(
        id: "tag6",
        resource: "assets/p6.jpg",
        thumnail: "assets/p1.jpg",
        isVideo: false),
    GalleryItem(
        id: "tag7",
        resource: "assets/p7.jpg",
        thumnail: "assets/p1.jpg",
        isVideo: false),
    GalleryItem(
        id: "tag7",
        resource: "https://www.youtube.com/watch?v=qPMeyCxKEUc",
        thumnail: 'assets/play_video.png',
        isVideo: true),
  ];
  bool verticalGallery = false;
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo Gallery'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GalleryImage(
                items: galleryItems,
                hImgage: 300,
                hThumnail: 50,
                wThumnail: 50,
              ),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Điện thoại Vsmart Live (64GB/6GB)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ))
            ],
          ),
        ));
  }
}
