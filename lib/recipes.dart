import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6/rec_model.dart';
import 'package:flutter_application_6/recipes_details.dart';
import 'package:http/http.dart' as http;

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  List<RecipesClass> recipes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes();
  }

  Future getRecipes() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));

    if (response.statusCode == 200) {
      RecModel rec = RecModel.fromJson(jsonDecode(response.body));

      setState(() {
        recipes = rec.recipes!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecipesDetails(
                            name: recipes[index].name!,
                            image: recipes[index].image!,
                            rating: recipes[index].rating!,
                            cuisine: recipes[index].cuisine!,
                            ingredients: recipes[index].ingredients!,
                          )));
                },
                child: Column(
                  children: [
                    Image.network(recipes[index].image!),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recipes[index].name!,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
