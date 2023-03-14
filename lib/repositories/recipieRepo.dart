import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cheezy_diary_recipie_app/models/recipies.dart';

class RecipiesRepository {
  final CollectionReference recipieCollection =
      FirebaseFirestore.instance.collection('recipies');

  Future addRecipie(String title, String description, String ingredients) async {
    return await recipieCollection.add({
      "title": title,
      "description": description,
      "ingredients":ingredients,
    });
  }

  Future editRecipie(id,String title, String description, String ingredients) async {
    await recipieCollection.doc(id).update({
      "title": title,
      "description": description,
      "ingredients":ingredients,
    });
  }

  Future removeRecipie(id) async {
    await recipieCollection.doc(id).delete();
  }

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
