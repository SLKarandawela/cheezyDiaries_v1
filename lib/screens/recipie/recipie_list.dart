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

import '../../widgets/bottom_icons.dart';
import '../../widgets/confirmation_dialog.dart';

class RecipieList extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('recipie');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: "My Recipies"),
          FutureBuilder<QuerySnapshot>(
            future: _reference.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("oops! something went wrong"),
                );
              }

              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data!;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                List<Recipie> myRecipies = documents
                    .map((e) => Recipie(
                        id: e['id'],
                        recipieTitle: e['recipieTitle'],
                        ingrediants: e['ingrediants'],
                        resDescription: e['resDescription']))
                    .toList();

                return _getBody(myRecipies);
              } else {
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RecipieCreate()));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomIconsWidget(),
    );
  }

 TextStyle headerTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  Widget _getBody(recipies) {
    return Expanded(
      child: ListView.builder(
        itemCount: recipies.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  10), // Add the same border radius to the container
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.5), // Choose your desired color
                  spreadRadius: 2, // The spread radius of the shadow
                  blurRadius: 5, // The blur radius of the shadow
                  offset: Offset(0, 3), // The position of the shadow
                ),
              ],
            ),
            child: Card(
              elevation: 4, // This will add a default shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10), // Add a border radius to the card
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(recipies[index].recipieTitle, style: headerTextStyle,),
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/cooking.png'),
                  ),
                  trailing: SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.preview,
                              color: Colors.blue.shade400,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipieUpdate(
                                            recipieItem: recipies[index],
                                          )));
                            },
                          ),
                          InkWell(
                            child: Icon(Icons.delete, color: Colors.red),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmationDialog(
                                    title: 'Confirm Deletion',
                                    message:
                                        'Are you sure you want to delete this item?',
                                    onConfirm: () {
                                      _reference
                                          .doc(recipies[index].id)
                                          .delete();
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecipieList()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
