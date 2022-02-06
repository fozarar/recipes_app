import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_6/models/recipe_model.dart';

class RecipeApi {
  static Future<List<RecipeModel>> getRecipe() async {
    var url = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {
      "limit": "18",
      "start": "0",
      "tag": "list.recipe.popular",
    });

    final response = await http.get(url, headers: {
      'x-rapidapi-host': 'yummly2.p.rapidapi.com',
      'x-rapidapi-key': '9ca49abdedmshc90ffde22c8fc82p1f513ajsn1e0440e60b91'
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return RecipeModel.recipeFromSnapshot(_temp);
  }
}
