import 'package:cheezy_diaries/model/journal/my_journal.dart';
import 'package:cheezy_diaries/model/workout/workouts.dart';
import 'package:cheezy_diaries/screens/journal/add_journal.dart';
import 'package:cheezy_diaries/screens/journal/update_journal.dart';
import 'package:cheezy_diaries/screens/workout/add_workout_log.dart';
import 'package:cheezy_diaries/screens/workout/edit_workout.dart';
import 'package:cheezy_diaries/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutList extends StatelessWidget {

  final CollectionReference  _reference = FirebaseFirestore.instance.collection('workout');

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
              List<Workout> workouts = documents
              .map((e) => Workout(
                id:e['id'],
                workoutFeedback: e['workoutFeedback'],
                 workoutComment: e['workoutComment'],
                 wDate: e['wDate'],
                 jumpingJackCount: e['jumpingJackCount'],
                 pushUpCount: e['pushUpCount'],
                  squatsCount: e['squatsCount'])).toList();
              return _getBody(workouts);
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          // child: _getBody()
          ),
        
        
      ],
    ),

    floatingActionButton: FloatingActionButton(onPressed: ((){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutCreate(),));
    })),
  );
      
  }
  
Widget _getBody(workouts) {
  return Expanded(
          child: ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(workouts[index].workoutFeedback),
                leading: const CircleAvatar(
                  radius: 25,
                ),
                trailing: SizedBox(
                  width: 60,
                  child: Row(
                  children: [
                    InkWell(child: Icon(Icons.edit),onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                         WorkoutEdit(workoutLog: workouts[index],)));
                    },),
                    InkWell(child: Icon(Icons.delete),onTap: () {
                      _reference.doc(workouts[index].id).delete();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> WorkoutList()));
                      
                    },)
                  ],
                )),
              ),
            ),
          ),

    
        );
}
}