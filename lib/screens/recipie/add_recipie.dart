import 'dart:math';
import 'package:cheezy_diaries/model/journal/my_journal.dart';
import 'package:cheezy_diaries/model/recipies/recipies.dart';
import 'package:cheezy_diaries/screens/journal/logs_list.dart';
import 'package:cheezy_diaries/widgets/date_picker.dart';
import 'package:cheezy_diaries/widgets/location_picker.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_icons.dart';
import '../../widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipieCreate extends StatefulWidget {
  const RecipieCreate({super.key});

  @override
  State<RecipieCreate> createState() => _RecipieCreateState();
}

class _RecipieCreateState extends State<RecipieCreate> {
  final TextEditingController resNamecontroller = TextEditingController();
  final TextEditingController resIngcontroller = TextEditingController();
  final TextEditingController resDesccontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:  [
          const ScreenHeader(title: "Create new recipie",),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                getMyField(hintText: 'Recipie name', controller: resNamecontroller),
                getMyField(hintText: 'Ingrediants', controller: resIngcontroller),
                getMyField(hintText: 'Preparing method', controller: resDesccontroller),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        // Recipie myRecipie = Recipie(logTitle: namecontroller.text, logDate: datecontroller.text, logDescription: desccontroller.text );
                        Recipie myRecipie = Recipie(recipieTitle: resNamecontroller.text, ingrediants: resIngcontroller.text, resDescription: resDesccontroller.text);
                        addRecipieAndNavigate(myRecipie, context);

                    }, 
                    child: const Text('Add'),),    
                    
                    ElevatedButton(
                      onPressed: (){
                        resNamecontroller.text = '';
                        resIngcontroller.text = '';
                        resDesccontroller.text = '';

                    }, 
                    child: const Text('Reset'),),   
                    
                                  ],
                )



              ],
            ),
          ))
        ],
      ),
      bottomNavigationBar: BottomIconsWidget(),
    );
  }

  Widget getMyField({required String hintText, required TextEditingController controller}){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter $hintText',labelText: hintText, border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))
          )
        ),
      ),
    );
  }
  
  void addRecipieAndNavigate(Recipie mRecipie, BuildContext context) {
    // reference to firebase
    final recipieRef = FirebaseFirestore.instance.collection('recipie').doc();
    mRecipie.id = recipieRef.id;
    final data = mRecipie.toJson();
    recipieRef.set(data).whenComplete((){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LogList(),));
    });
  }



}