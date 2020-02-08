import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:demo_flutter/screens/app_bar.dart';
import 'package:demo_flutter/screens/examples/gallery/gallery_example_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'gallery_image.dart';

class GalleryExample extends StatefulWidget {
  @override
  _GalleryExampleState createState() => _GalleryExampleState();
}

class _GalleryExampleState extends State<GalleryExample> {
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
              GalleryImage(),
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
