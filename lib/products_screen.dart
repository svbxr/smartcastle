import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6/catalogModal.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  String categoryName;
  ProductsScreen({super.key, required this.categoryName});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Products> productsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  Future getProducts() async {
    final response = await http.get(Uri.parse(
        'https://dummyjson.com/products/category/${widget.categoryName}'));
    if (response.statusCode == 200) {
      CatalogModal catalogModal =
          CatalogModal.fromJson(jsonDecode(response.body));
      setState(() {
        productsList = catalogModal.products!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: productsList.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          productsList[index].images!.first,
                          width: double.infinity,
                        ),
                      ),
                      Text(
                        productsList[index].title!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${productsList[index].price.toString()} ₸',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
