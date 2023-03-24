import 'dart:math';
import 'package:cheezy_diaries/model/journal/my_journal.dart';
import 'package:cheezy_diaries/model/recipies/recipies.dart';
import 'package:cheezy_diaries/model/workout/workouts.dart';
import 'package:cheezy_diaries/screens/journal/logs_list.dart';
import 'package:cheezy_diaries/screens/workout/workout_list.dart';
import 'package:cheezy_diaries/widgets/date_picker.dart';
import 'package:cheezy_diaries/widgets/location_picker.dart';
import 'package:cheezy_diaries/widgets/numberInp.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_icons.dart';
import '../../widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutEdit extends StatelessWidget {

  final Workout workoutLog;

  final TextEditingController workNamecontroller = TextEditingController();

  final TextEditingController workDesccontroller = TextEditingController();

  final TextEditingController workDatecontroller = TextEditingController();

  final TextEditingController pushUpCountcontroller = TextEditingController();

  final TextEditingController jumpingJackCountcontroller = TextEditingController();

  final TextEditingController squatsCountCountcontroller = TextEditingController();


  WorkoutEdit({super.key, required this.workoutLog});


  @override
  Widget build(BuildContext context) {
     workNamecontroller.text = workoutLog.workoutFeedback;
     workDesccontroller.text = workoutLog.workoutComment;
     workDatecontroller.text = workoutLog.wDate;
     pushUpCountcontroller.text = '${workoutLog.pushUpCount}';
     jumpingJackCountcontroller.text = '${workoutLog.jumpingJackCount}';
     squatsCountCountcontroller.text = '${workoutLog.squatsCount}';
    return Scaffold(
      body: Column(
        children:  [
          const ScreenHeader(title: "Edit a workout log",),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                getMyField(hintText: 'Workout feedback', controller: workNamecontroller),
                getMyField(hintText: 'Workout description', controller: workDesccontroller),
                DatePickerFormField(hintText: "Workout date", textEditingController: workDatecontroller),
                PositiveIntegerField(hintText: 'Push ups', textEditingController: pushUpCountcontroller),
                PositiveIntegerField(hintText: 'Jumping jacks', textEditingController: jumpingJackCountcontroller),
                PositiveIntegerField(hintText: 'Squats', textEditingController: squatsCountCountcontroller),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Workout updatedWorkout = Workout(
                          id: workoutLog.id,
                          workoutFeedback: workNamecontroller.text,
                           workoutComment: workDesccontroller.text,
                            wDate: workDatecontroller.text,
                            jumpingJackCount: int.parse(jumpingJackCountcontroller.text),
                             pushUpCount: int.parse(pushUpCountcontroller.text),
                              squatsCount: int.parse(squatsCountCountcontroller.text));
                        
                      final CollectionReference = FirebaseFirestore.instance.collection('workout');
                        CollectionReference.doc(updatedWorkout.id).update(updatedWorkout.toJson()).whenComplete((){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> WorkoutList()));
                        });
                    }, 
                    child: const Text('Update'),),    
                    
                    ElevatedButton(
                      onPressed: (){
                        workNamecontroller.text = '';
                        workDesccontroller.text = '';
                        workDatecontroller.text = '';
                        pushUpCountcontroller.text = '';
                        jumpingJackCountcontroller.text = '';
                        squatsCountCountcontroller.text = '';
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

  
}