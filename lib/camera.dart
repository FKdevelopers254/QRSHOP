import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';


import 'package:camera/saved_products.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cameratwo.dart';
import 'docx.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  List<Product> products = [];
  double _totalPrice = 0;



  Future<void> _saveToSpreadsheets() async {
    // Get the directory for storing the file
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/products.xlsx';

    // Create or open the spreadsheet file
    final file = File(filePath);
    final excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Add the product data to the spreadsheet
    int rowIndex = sheet.maxRows + 1;
    for (Product product in products) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)).value = product.name;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex)).value = product.price;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex)).value = product.quantity;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex)).value = product.price * product.quantity;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex)).value = DateTime.now().toString();
      rowIndex++;
    }

    // Save the spreadsheet file and open it
    await file.writeAsBytes(excel.encode()!);
    await OpenFile.open(filePath);
  }



  Future<void> _saveToSpreadsheet() async {
    // Get the directory for storing the file
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/products.xlsx';

    // Create or open the spreadsheet file
    final file = File(filePath);
    final excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Add the product data to the spreadsheet
    int rowIndex = sheet.maxRows + 1;
    for (Product product in products) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)).value = product.name;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex)).value = product.price;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex)).value = product.quantity;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex)).value = product.price * product.quantity;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex)).value = DateTime.now().toString();
      rowIndex++;
    }

    // Save the spreadsheet file
    await file.writeAsBytes(excel.encode()!);

    // Show a snackbar message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully')),
    );

    // Clear the products list and update the total price
    setState(() {
      products.clear();
      _totalPrice = 0;
    });
  }







  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Products:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}'),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                product.quantity--;
                                _totalPrice -= product.price;
                              });
                            },
                          ),
                          Text(product.quantity.toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                product.quantity++;
                                _totalPrice += product.price;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        products.removeAt(index);
                        _totalPrice -= product.price * product.quantity;
                      });
                    },
                  ),
                );
              },
            ),
          ),


          Text(
            'Total: \$${_getTotalPrice().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),



          ElevatedButton(
            child: Text('Save and Open'),
            onPressed: () async {
              // Save the data to the spreadsheet file
              await _saveToSpreadsheets();

              // Clear the products list and update the total price
              setState(() {
                products.clear();
                _totalPrice = 0;
              });
            },
          ),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () async {
              // Save the data to the spreadsheet file
              await _saveToSpreadsheet();

              // Clear the products list and update the total price

            },
          ),




          ElevatedButton(
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => QRPage()));
              },
              child: Text('Make QR')),
          ElevatedButton(
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => QRScannerPaget()));
              },
              child: Text('QR Scanner Two')),




          SizedBox(height: 20),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      List<String>? data = scanData.code?.split(' ');
      String name = data![0];
      double price = double.parse(data[1]);
      bool isProductInList = products.any((product) => product.name == name);
      if (!isProductInList) {
        setState(() {
          products.add(Product(name: name, price: price, date: DateTime.now()));
        });
      }
    });
  }





  double _getTotalPrice() {
    double total = 0;
    for (Product product in products) {
      total += product.price * product.quantity;
    }
    return total;
  }

}

class Product {
  final String name;
  final double price;
  int quantity;
  DateTime date;

  Product({required this.name, required this.price,required this.date, this.quantity = 1});
}
