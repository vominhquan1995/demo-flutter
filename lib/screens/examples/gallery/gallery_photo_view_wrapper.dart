import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'gallery_item.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper(
      {this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialId,
      @required this.items,
      this.scrollDirection = Axis.horizontal,
      this.hThumnail = 50,
      this.wThumnail = 50})
      : pageController = PageController(
            initialPage: items.indexWhere((x) => x.id == initialId));

  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String initialId;
  final PageController pageController;
  final List<GalleryItem> items;
  final Axis scrollDirection;
  final double hThumnail;
  final double wThumnail;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.items.indexWhere((x) => x.id == widget.initialId);
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
      itemCount: widget.items.length,
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
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int i) => Container(
          width: widget.wThumnail,
          height: widget.hThumnail,
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
              child: Image.asset(widget.items[i].resource),
            ),
          )),
      height: widget.hThumnail,
      viewportFraction: 0.2, //full screen
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
      enableInfiniteScroll: false, //cuộn qua lại
      reverse: false, //đảo chiều
      onPageChanged: (index) {},
      initialPage: currentIndex,
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
    final GalleryItem item = widget.items[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: AssetImage(item.resource),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
