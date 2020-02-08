import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'gallery_example_item.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingChild,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    @required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryExampleItem> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic thumnails;
    final images = PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: _buildItem,
      itemCount: galleryItems.length,
      loadingChild: widget.loadingChild,
      backgroundDecoration: BoxDecoration(
        color: Colors.white,
      ),
      pageController: widget.pageController,
      onPageChanged: (index) {
        thumnails.jumpToPage(index);
        setState(() {
          currentIndex = index;
        });
      },
      scrollDirection: widget.scrollDirection,
    );
    thumnails = CarouselSlider.builder(
      itemCount: galleryItems.length,
      itemBuilder: (BuildContext context, int i) => Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.all(2.0),
          child: Container(
            decoration: currentIndex == i
                ? BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: const BorderRadius.all(Radius.circular(5)))
                : BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = i;
                });
                widget.pageController.jumpToPage(i);
              }, // handle your image tap here
              child: Image.asset(galleryItems[i].resource),
            ),
          )),
      height: 50,
      viewportFraction: 0.2, //full screen
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
      enableInfiniteScroll: false, //cuộn qua lại
      reverse: false, //đảo chiều
      onPageChanged: (index) {},
    );

    return Scaffold(
      // appBar: AppBar(),
      body: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          // constraints: BoxConstraints.expand(
          //   height: MediaQuery.of(context).size.height,
          // ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: new Icon(
                        Icons.close,
                        color: Colors.black38,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: images,
                flex: 8,
              ),
              Expanded(
                child: thumnails,
                flex: 1,
              )
            ],
          )),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryExampleItem item = widget.galleryItems[index];
    return item.isSvg
        ? PhotoViewGalleryPageOptions.customChild(
            child: Container(
              width: 300,
              height: 300,
              child: SvgPicture.asset(
                item.resource,
                height: 200.0,
              ),
            ),
            childSize: const Size(300, 300),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
            maxScale: PhotoViewComputedScale.covered * 1.1,
            heroAttributes: PhotoViewHeroAttributes(tag: item.id),
          )
        : PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(item.resource),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
            maxScale: PhotoViewComputedScale.covered * 1.1,
            heroAttributes: PhotoViewHeroAttributes(tag: item.id),
          );
  }
}
