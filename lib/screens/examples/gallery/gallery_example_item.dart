import 'package:flutter/widgets.dart';

class GalleryExampleItem {
  GalleryExampleItem({this.id, this.resource, this.isSvg = false});

  final String id;
  final String resource;
  final bool isSvg;
}

class GalleryExampleItemThumbnail extends StatelessWidget {
  const GalleryExampleItemThumbnail(
      {Key key, this.galleryExampleItem, this.onTap})
      : super(key: key);

  final GalleryExampleItem galleryExampleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryExampleItem.id,
          child: Image.asset(galleryExampleItem.resource, height: 80.0),
        ),
      ),
    );
  }
}

List<GalleryExampleItem> galleryItems = <GalleryExampleItem>[
  GalleryExampleItem(
    id: "tag1",
    resource: "assets/p1.jpg",
  ),
  GalleryExampleItem(
    id: "tag2",
    resource: "assets/p2.jpg",
  ),
  GalleryExampleItem(
    id: "tag3",
    resource: "assets/p3.jpg",
  ),
  GalleryExampleItem(
    id: "tag4",
    resource: "assets/p4.jpg",
  ),
  GalleryExampleItem(
    id: "tag5",
    resource: "assets/p5.jpg",
  ),
  GalleryExampleItem(
    id: "tag6",
    resource: "assets/p6.jpg",
  ),
  GalleryExampleItem(
    id: "tag7",
    resource: "assets/p7.jpg",
  ),
];
