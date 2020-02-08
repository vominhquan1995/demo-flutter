import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gallery_example_item.dart';
import 'gallery_photo_view_wrapper.dart';

class GalleryImage extends StatefulWidget {
  GalleryImage({Key key}) : super(key: key);

  @override
  _GalleryImageState createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  dynamic index;
  dynamic images;
  dynamic thumnails;
  @override
  @override
  void initState() {
    super.initState();
    setState(() {
      index = 0;
    });
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
            galleryItems: galleryItems,
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            initialIndex: index,
            scrollDirection: Axis.horizontal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    thumnails = CarouselSlider.builder(
      itemCount: galleryItems.length,
      itemBuilder: (BuildContext context, int i) => Container(
          margin: const EdgeInsets.all(2.0),
          child: Container(
            height: 50,
            width: 50,
            decoration: index == i
                ? BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: const BorderRadius.all(Radius.circular(5)))
                : BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = i;
                });
                images.jumpToPage(i);
              }, // handle your image tap here
              child: Image.asset(galleryItems[i].resource),
            ),
          )),
      enlargeCenterPage: false, //effect scale item when scroll
      height: 50,
      viewportFraction: 0.2, //full screen
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
      enableInfiniteScroll: false, //cuộn qua lại
      initialPage: index,
      reverse: false, //đảo chiều list
      onPageChanged: (index) {},
    );
    images = CarouselSlider.builder(
      itemCount: galleryItems.length,
      itemBuilder: (BuildContext context, int i) => Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                index = i;
              });
            }, // handle your image tap here
            child: GestureDetector(
              onTap: () {
                open(context, i);
              }, // handle your image tap here
              child: Image.asset(galleryItems[i].resource),
            ),
          )),
      height: 300,
      initialPage: index,
      reverse: false,
      enableInfiniteScroll: false,
      viewportFraction: 1.0, //full screen
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
      onPageChanged: (i) {
        setState(() {
          index = i;
        });
        thumnails.jumpToPage(i);
      },
    );
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[images, thumnails],
      ),
    );
  }
}
