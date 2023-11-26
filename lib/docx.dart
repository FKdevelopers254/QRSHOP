import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';


import 'camera.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
   String productName ='';
   String productPrice= '';


   final GlobalKey _qrKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code'),
        actions: const [],
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
                    decoration: InputDecoration(
                      hintText: 'Product Name',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      prefixIcon: const Icon(Icons.shopping_cart),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            productName = '';
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        productName = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),





                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Product Price',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      prefixIcon: const Icon(Icons.attach_money),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            productPrice = '';
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        productPrice = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

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
