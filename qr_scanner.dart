import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

enum QrEnum { hodoorConfig, hodoorDeviceCreate, remoteControllerSettings }

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key, required this.qrEnum, this.locations, this.offices}) : super(key: key);
  final QrEnum qrEnum;

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resumeCamer();
  }

  resumeCamer() async {
    await Future.delayed(Duration(seconds: 1));
    await controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(borderColor: Colors.deepOrangeAccent, borderWidth: 10, borderRadius: 20),
              onQRViewCreated: _onQRViewCreated),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () async {
                      await controller!.toggleFlash();
                    },
                    icon: Icon(
                      Icons.flash_on,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () async {
                      await controller!.flipCamera();
                    },
                    icon: Icon(
                      Icons.flip_camera_ios,
                      color: Colors.white,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      //do with data
    });
  }
}
