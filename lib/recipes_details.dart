import 'package:flutter/material.dart';

class RecipesDetails extends StatefulWidget {
  String name;
  String? image;
  dynamic rating;
  String cuisine;
  List<String> ingredients;
  RecipesDetails(
      {super.key,
      required this.name,
      required this.image,
      required this.rating,
      required this.cuisine,
      required this.ingredients});

  @override
  State<RecipesDetails> createState() => _RecipesDetailsState();
}

class _RecipesDetailsState extends State<RecipesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Column(
              children: [
                Image.network(widget.image!),
              ],
            ),
            Row(
              children: [
                Text('Rating: ${widget.rating.toString()}'),
              ],
            ),
            Row(
              children: [
                Text('Cuisine: ${widget.cuisine}'),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text('Ingredients:'),
                  ],
                ),
                for (String ingredient in widget.ingredients) Row(
                  children: [
                    Text(ingredient),
                  ],
                )
              ],
            ),
            
          ]),
        ),
      ),
    );
  }
}
