import 'package:flutter/material.dart';
import 'package:demo_flutter/screens/examples/controller_example.dart';
import 'package:demo_flutter/screens/examples/custom_child_examples.dart';
import 'package:demo_flutter/screens/examples/dialog_example.dart';
import 'package:demo_flutter/screens/examples/full_screen_examples.dart';
import 'package:demo_flutter/screens/examples/gallery/gallery_example.dart';
import 'package:demo_flutter/screens/examples/hero_example.dart';
import 'package:demo_flutter/screens/examples/inline_examples.dart';
import 'package:demo_flutter/screens/examples/rotation_examples.dart';
import 'package:demo_flutter/screens/examples/qr_scan_example.dart';
import './app_bar.dart';
import 'examples/navigator_drawer_filter/navigator_drawer_filter.dart';
import 'examples/search_bar_example.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const ExampleAppBar(title: "List Demo"),
          Expanded(
            child: ListView(
              children: <Widget>[
                // _buildItem(context, onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => FullScreenExamples(),
                //     ),
                //   );
                // }, text: "Full screen"),
                // _buildItem(context, onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => ControllerExample(),
                //     ),
                //   );
                // }, text: "Controller"),
                // _buildItem(context, onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => InlineExample(),
                //     ),
                //   );
                // }, text: "Part of the screen"),
                // _buildItem(context, onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => RotationExamples(),
                //     ),
                //   );
                // }, text: "Rotation Gesture"),
                // _buildItem(context, onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (_) => HeroExample(),
                //     ),
                //   );
                // }, text: "Hero animation"),
                _buildItem(context, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GalleryExample(),
                    ),
                  );
                }, text: "Gallery"),
                // _buildItem(context, onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (_) => CustomChildExample(),
                //     ),
                //   );
                // }, text: "Custom child"),
                // _buildItem(context, onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => DialogExample(),
                //     ),
                //   );
                // }, text: "Integrated to dialogs"),
                _buildItem(context, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrScanExample(),
                    ),
                  );
                }, text: "QR Scan"),
                _buildItem(context, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigatorDrawerFilter(),
                    ),
                  );
                }, text: "Navigator Drawer Filter"),
                _buildItem(context, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchBarExample(),
                    ),
                  );
                }, text: "Search Page"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(context, {String text, Function onPressed}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Colors.black12,
      child: FlatButton(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
