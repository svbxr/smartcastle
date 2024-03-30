import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6/products_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_6/catalogModal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
  }

  Future getCategories() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products/categories'));

    if (response.statusCode == 200) {

      setState(() {
        categories = List.from(jsonDecode(response.body));
      });
    }
  }

  String capitalizeOnlyFirstLetter(String word) {
    return word.substring(0, 1).toUpperCase() + word.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductsScreen(
                                categoryName: categories[index],
                              )));
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.green),
                  child: Text(
                    capitalizeOnlyFirstLetter(categories[index]),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
