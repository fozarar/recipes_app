// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_6/models/recipe_model.dart';
import 'package:flutter_application_6/services/recipe_api.dart';
import 'package:flutter_application_6/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RecipeModel>? _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
    print(_recipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.restaurant_menu,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Text(
                'Food Recipe',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _recipes!.length,
                itemBuilder: (context, i) {
                  return RecipeCard(
                    title: _recipes![i].name,
                    cookTime: _recipes![i].totalTime,
                    rating: _recipes![i].rating.toString(),
                    thumbnailUrl: _recipes![i].images,
                  );
                }));
  }
}
