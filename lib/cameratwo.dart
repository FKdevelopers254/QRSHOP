
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';


import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


import 'docx.dart';

class QRScannerPaget extends StatefulWidget {
  @override
  _QRScannerPagetState createState() => _QRScannerPagetState();
}

class _QRScannerPagetState extends State<QRScannerPaget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  late QRViewController controller;
  List<Product> products = [];
  double _totalPrice = 0;



  Future<void> _saveToSpreadsheets() async {
    // Get the directory for storing the file
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/products.xlsx';

    // Check if the file exists
    final file = File(filePath);
    if (!await file.exists()) {
      // If the file doesn't exist, create a new one with a header row
      final excel = Excel.createExcel();
      Sheet sheet = excel['Sheet1'];
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value = 'Name';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value = 'Price';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value = 'Quantity';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value = 'Total Price';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value = 'Date';
      await file.writeAsBytes(excel.encode()!);
    }

    // Open the existing file and append the new data to the end of the file
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    Sheet sheet = excel['Sheet1'];
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


    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('Product added successfully.'),
      ),
    );

    setState(() {
      products.clear();
      _totalPrice = 0;
    });

  }


  Future<void> _saveToSpreadsheet() async {
    // Get the directory for storing the file
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/products.xlsx';

    // Check if the file exists
    final file = File(filePath);
    if (!await file.exists()) {
      // If the file doesn't exist, create a new one with a header row
      final excel = Excel.createExcel();
      Sheet sheet = excel['Sheet1'];
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value = 'Name';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value = 'Price';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value = 'Quantity';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value = 'Total Price';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value = 'Date';
      await file.writeAsBytes(excel.encode()!);
    }

    // Open the existing file and append the new data to the end of the file
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    Sheet sheet = excel['Sheet1'];
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


    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('Product added successfully.'),
      ),
    );



    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data saved successfully')),
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
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Scan QR Code',
            style: GoogleFonts.andika(),
          ),
          actions: const [],
          backgroundColor: Colors.blue, // Set the background color of the AppBar
          centerTitle: true, // Center align the title
          elevation: 2, // Add a shadow effect to the AppBar
          iconTheme: const IconThemeData(color: Colors.white), toolbarTextStyle: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).bodyMedium, titleTextStyle: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).titleLarge, // Set the text style of the title
        )
        ,
        body: Column(
          children: [
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  onPressed: () async {
                    // Save the data to the spreadsheet file
                    await _saveToSpreadsheets();

                    // Clear the products list and update the total price
                    setState(() {
                      products.clear();
                      _totalPrice = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Set the button's background color
                    onPrimary: Colors.white, // Set the button's text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set the button's border radius
                    ),
                  ),
                  child: Text(
                    'Save and Open',
                    style: TextStyle(
                      fontSize: 16, // Set the button's text size
                      fontWeight: FontWeight.bold, // Set the button's text weight
                    ),
                  ),
                )
,

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QRPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Set the button's text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set the button's border radius
                    ),
                  ),
                  child: const Text(
                    'Create QR Code',
                    style: TextStyle(
                      fontSize: 16, // Set the button's text size
                      fontWeight: FontWeight.bold, // Set the button's text weight
                    ),
                  ),
                ),






                ElevatedButton(
                  onPressed: () async {
                    // Save the data to the spreadsheet file
                    await _saveToSpreadsheet();

                    // Clear the products list and update the total price

                    setState(() {
                      products.clear();
                      _totalPrice = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Set the button's text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set the button's border radius
                    ),
                  ),
                  child: Text(
                    'Quick Save',
                    style: TextStyle(
                      fontSize: 16, // Set the button's text size
                      fontWeight: FontWeight.bold, // Set the button's text weight
                    ),
                  ),
                )
                ,

              ],
            ),
            Text(
              'Products:',
              style: GoogleFonts.andika(
                fontSize: 20, // Set the text's font size
                fontWeight: FontWeight.bold, // Set the text's font weight
                color: Colors.blue, // Set the text's color
              ),
            )
            ,
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Card(
                    color: Colors.blue.withOpacity(0.6),
                    child: ListTile(
                      title: Text(
                        product.name,
                        style: GoogleFonts.andika(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ksh ${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.andika(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.remove, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      product.quantity--;
                                      _totalPrice -= product.price;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.quantity.toString(),
                                  style: GoogleFonts.andika(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.add, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      product.quantity++;
                                      _totalPrice += product.price;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            products.removeAt(index);
                            _totalPrice -= product.price * product.quantity;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),


            Text(
              'Total: \$${_getTotalPrice().toStringAsFixed(2)}',
              style: GoogleFonts.andika(
                fontSize: 20, // Set the text's font size
                fontWeight: FontWeight.bold, // Set the text's font weight
                color: Colors.green, // Set the text's color
              ),
            )
            ,







            const SizedBox(height: 20),
          ],
        ),
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
