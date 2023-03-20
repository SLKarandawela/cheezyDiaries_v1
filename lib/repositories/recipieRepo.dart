import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cheezy_diary_recipie_app/models/recipies.dart';

class RecipiesRepository {
  final CollectionReference recipieCollection =
      FirebaseFirestore.instance.collection('recipies');

  //Add Recipe
  Future addRecipie(String title, String description, String ingredients) async {
    return await recipieCollection.add({
      "title": title,
      "description": description,
      "ingredients":ingredients,
    });
  }

  //Edit Recipe
  Future editRecipie(id,String title, String description, String ingredients) async {
    await recipieCollection.doc(id).update({
      "title": title,
      "description": description,
      "ingredients":ingredients,
    });
  }

  //Delete Recipe
  Future removeRecipie(id) async {
    await recipieCollection.doc(id).delete();
  }

  //Retrieve Recipe List
  List<Recipies> recipiesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Recipies(
        description: e.get("description"),
        ingredients: e.get("ingredients"),
        title: e.get("title"),
        id: e.id,
      );
    }).toList();
  }

  Stream<List<Recipies>> listRecipies() {
    return recipieCollection.snapshots().map(recipiesList);
  }
}
