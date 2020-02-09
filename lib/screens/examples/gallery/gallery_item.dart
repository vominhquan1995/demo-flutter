import 'package:flutter/widgets.dart';
class GalleryItem {
  GalleryItem({this.id, this.resource, this.thumnail, this.isVideo = false});
  final String id;
  final String resource;
  final String thumnail;
  final bool isVideo;
}
class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({Key key, this.galleryItem, this.onTap})
      : super(key: key);
  final GalleryItem galleryItem;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryItem.id,
          child: Image.asset(galleryItem.resource, height: 80.0),
        ),
      ),
    );
  }
}
