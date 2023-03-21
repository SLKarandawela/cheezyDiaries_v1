import 'package:cheezy_diaries/model/journal/my_journal.dart';
import 'package:cheezy_diaries/model/recipies/recipies.dart';
import 'package:cheezy_diaries/screens/journal/add_journal.dart';
import 'package:cheezy_diaries/screens/journal/update_journal.dart';
import 'package:cheezy_diaries/screens/recipie/add_recipie.dart';
import 'package:cheezy_diaries/screens/recipie/update_recipies.dart';
import 'package:cheezy_diaries/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipieList extends StatelessWidget {

  final CollectionReference  _reference = FirebaseFirestore.instance.collection('recipie');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: [
        const ScreenHeader(),
        FutureBuilder<QuerySnapshot>(
          future: _reference.get(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Center(child: Text("oops! something went wrong"),);
            }

            if(snapshot.hasData){
              QuerySnapshot querySnapshot = snapshot.data!;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;
              List<Recipie> myRecipies = documents.map((e) => Recipie(id:e['id'],recipieTitle: e['recipieTitle'], ingrediants: e['ingrediants'], resDescription: e['resDescription'])).toList();
              
              return _getBody(myRecipies);
            }
            else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          ),
        
        
      ],
    ),

    floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RecipieCreate()));
  },
  child: Icon(Icons.add),
),
  );
      
  }
  
Widget _getBody(recipies) {
  return Expanded(
          child: ListView.builder(
            itemCount: recipies.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(recipies[index].recipieTitle),
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/fry.png'),
            
                  ),
                  trailing: SizedBox(
                    width: 60,
                    child: Row(
                    children: [
                      InkWell(child: Icon(Icons.edit),onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                           RecipieUpdate(recipieItem: recipies[index],)));
                      },),
                      InkWell(child: Icon(Icons.delete),onTap: () {
                        _reference.doc(recipies[index].id).delete();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RecipieList()));
                        
                      },)
                    ],
                  )),
                ),
              ),
            ),
          ),

    
        );
}
}