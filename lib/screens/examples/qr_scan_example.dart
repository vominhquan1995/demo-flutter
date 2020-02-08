import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_flutter/screens/examples/qr_scan.dart';
import 'package:toast/toast.dart';

var allowedExtension = ['.jpeg', '.jpg', '.png', '.gif', '.bmp', 'images'];

class QrScanExample extends StatefulWidget {
  QrScanExample({Key key}) : super(key: key);

  @override
  _QrScanExampleState createState() => _QrScanExampleState();
}

class _QrScanExampleState extends State<QrScanExample> {
  TextEditingController txtSearch = new TextEditingController();
  String valueScan = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo QR'),
        ),
        body: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 8,
                        child: TextField(
                          controller: txtSearch,
                          maxLines: 2,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  gapPadding: 1,
                                  borderSide: BorderSide(
                                      color: Colors.black12, width: 1.0)),
                              hintText: 'Tìm kiếm sản phẩm'),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QrScan(
                                              onScanSuccess: (value) {
                                                // txtSearch.text = value;
                                                valueScan = value;
                                              },
                                            )));
                              },
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/icon_qr.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  Text('Quét', style: TextStyle(fontSize: 8))
                                ],
                              )),
                        )),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.all(10),
                child: _buildContent(),
              ))
            ],
          ),
        ));
  }

  bool checkFormat(String input) {
    bool result = false;
    allowedExtension.forEach((x) {
      if (input.contains(x)) {
        result = true;
      }
    });
    return result;
  }

  _buildContent() {
    if (checkFormat(valueScan.toString())) {
      return Container(
        child: Image(image: NetworkImage(valueScan)),
      );
    } else {
      return Container(
        child: Text(
          valueScan,
          style: TextStyle(color: Colors.black),
        ),
      );
    }
  }
}
