import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/catalogModal.dart';
import 'package:http/http.dart' as http;

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Products> productsFromServer = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getCatalogs();
  }

  Future getCatalogs() async {
    final respose = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (respose.statusCode == 200) {
      CatalogModal catalogModal =
          CatalogModal.fromJson(jsonDecode(respose.body));
      setState(() {
        productsFromServer = catalogModal.products!;
        loading = false;
      });
    } else {
      throw 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          productsFromServer.clear();
          setState(() {
            loading = true;
          });
          getCatalogs();
        },
        child: loading
            ? Center(
                child:
                    CupertinoActivityIndicator()) // Если загрузка, показываем индикатор
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: productsFromServer.length,
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
                                productsFromServer[index].images!.first,
                                width: double.infinity,
                              ),
                            ),
                            Text(
                              productsFromServer[index].title!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${productsFromServer[index].price.toString()} ₸',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
