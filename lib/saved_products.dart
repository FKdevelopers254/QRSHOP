import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'camera.dart';



class SavedProductsPage extends StatefulWidget {
  @override
  _SavedProductsPageState createState() => _SavedProductsPageState();
}

class _SavedProductsPageState extends State<SavedProductsPage> {
  List<Product> _products = [];


  @override
  void initState() {
    super.initState();
    loadProductsFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Products'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          Product product = _products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\$${product.price.toStringAsFixed(2)}'),
                SizedBox(height: 10),
                Text('Quantity: ${product.quantity}'),
                SizedBox(height: 10),
                Text('Total Price: \$${(product.price * product.quantity).toStringAsFixed(2)}'),
                SizedBox(height: 10),
                Text('Date: ${DateFormat.yMd().add_Hm().format(product.date)}'),
              ],
            ),
          );
        },
      ),
    );
  }

  void loadProductsFromServer() async {
    const url = 'https://markiniltd.com/getproducts.php';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Product> products = data.map((item) {
        return Product(
          name: item['name'],
          price: item['price'],
          quantity: item['quantity'],
          date: DateTime.parse(item['date']),
        );
      }).toList();
      setState(() {
        _products = products;
      });
    } else {
      print('Error loading products: ${response.reasonPhrase}');
    }
  }
}
