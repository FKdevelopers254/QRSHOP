import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';


import 'camera.dart';

class QRPage extends StatefulWidget {
  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
   String productName ='';
   String productPrice= '';


   GlobalKey _qrKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code'),
        actions: [],
      ),
      body: Column(
        children: [

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Product Name'),
                    onChanged: (value) {
                      setState(() {
                        productName = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(hintText: 'Product Price'),
                    onChanged: (value) {
                      setState(() {
                        productPrice = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),

                  if (productName != null && productPrice != null)
                    PrettyQr(
                      data: '$productName $productPrice',
                      size: 200,
                      roundEdges: true,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
