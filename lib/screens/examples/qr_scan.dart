import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

const flash_on = "FLASH ON";
const flash_off = "FLASH OFF";

class QrScan extends StatefulWidget {
  final Function(dynamic) onScanSuccess;
  QrScan({Key key, @required this.onScanSuccess})
      : assert(
            onScanSuccess != null, 'Bắt buộc phải có hàm onScanSuccess data'),
        super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  var flashState = flash_off;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 0,
                borderLength: 10,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
            flex: 9,
          ),
          Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.all(5),
                child: FlatButton(
                  onPressed: () {
                    controller.toggleFlash();
                    if (_isFlashOn(flashState)) {
                      setState(() {
                        flashState = flash_off;
                      });
                    } else {
                      setState(() {
                        flashState = flash_on;
                      });
                    }
                  },
                  color: Colors.black26,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Replace with a Row for horizontal icon + text
                    children: _buildButtton(),
                  ),
                )),
          )
        ],
      ),
    );
  }

  List<Widget> _buildButtton() {
    List<Widget> out = [];
    if (_isFlashOn(flashState)) {
      out.add(Icon(Icons.flash_off));
      out.add(const Text("Tắt đèn flash"));
    } else {
      out.add(Icon(Icons.flash_on));
      out.add(const Text("Mở đèn flash"));
    }
    return out;
  }

  bool _isFlashOn(String current) {
    return flash_on == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // controller.toggleFlash();
      controller.pauseCamera();
      // print('scan success with value ${scanData}');
      Future.delayed(const Duration(milliseconds: 1000), () {
        //push value to page
        widget.onScanSuccess(scanData);
        Navigator.of(context).pop();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
