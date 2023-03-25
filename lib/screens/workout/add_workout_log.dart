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

import '../../widgets/loader_navigator.dart';

class WorkoutCreate extends StatefulWidget {
  const WorkoutCreate({super.key});

  @override
  State<WorkoutCreate> createState() => _WorkoutCreateState();
}

class _WorkoutCreateState extends State<WorkoutCreate> {
  final TextEditingController workNamecontroller = TextEditingController();
  final TextEditingController workDesccontroller = TextEditingController();
  final TextEditingController workDatecontroller = TextEditingController();
  final TextEditingController pushUpCountcontroller = TextEditingController();
  final TextEditingController jumpingJackCountcontroller =
      TextEditingController();
  final TextEditingController squatsCountCountcontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        children: [
          const ScreenHeader(
            title: "Create a workout log",
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  getMyField(
                      hintText: 'Workout feedback',
                      controller: workNamecontroller),
                  getMyField(
                      hintText: 'Workout description',
                      controller: workDesccontroller),
                  DatePickerFormField(
                      hintText: "Workout date",
                      textEditingController: workDatecontroller),
                  PositiveIntegerField(
                      hintText: 'Push ups',
                      textEditingController: pushUpCountcontroller),
                  PositiveIntegerField(
                      hintText: 'Jumping jacks',
                      textEditingController: jumpingJackCountcontroller),
                  PositiveIntegerField(
                      hintText: 'Squats',
                      textEditingController: squatsCountCountcontroller),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              // Recipie myRecipie = Recipie(logTitle: namecontroller.text, logDate: datecontroller.text, logDescription: desccontroller.text );
                              Workout myWorkout = Workout(
                                  workoutFeedback: workNamecontroller.text,
                                  workoutComment: workDesccontroller.text,
                                  wDate: workDatecontroller.text,
                                  jumpingJackCount:
                                      int.parse(jumpingJackCountcontroller.text),
                                  pushUpCount: int.parse(pushUpCountcontroller.text),
                                  squatsCount:
                                      int.parse(squatsCountCountcontroller.text));
                              addWorkoutAndNavigate(myWorkout, context);
                            },
                            child: const Text('Add'),
                            style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        Colors.green.shade400),
                                    shape:
                                        MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        side: BorderSide(color: Colors.green, width: 2.0),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              workNamecontroller.text = '';
                              workDesccontroller.text = '';
                              workDatecontroller.text = '';
                              pushUpCountcontroller.text = '';
                              jumpingJackCountcontroller.text = '';
                              squatsCountCountcontroller.text = '';
                            },
                            child: const Text('Reset'),
                            style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.blue.shade300),
                                  shape:
                                      MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(color: Colors.blue, width: 2.0),
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          )
        ],
      ),
      bottomNavigationBar: BottomIconsWidget(),
    );
  }

  Widget getMyField(
      {required String hintText, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: 'Enter $hintText',
            labelText: hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
      ),
    );
  }

  void addWorkoutAndNavigate(Workout mWorkout, BuildContext context) {
    // reference to firebase
    final wkRef = FirebaseFirestore.instance.collection('workout').doc();
    mWorkout.id = wkRef.id;
    final data = mWorkout.toJson();
    wkRef.set(data).whenComplete(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingPage(
              nextPage: WorkoutList(),
              imageAsset: 'assets/images/health.png',
              loadingText: 'Creating a workout...',
            ),
          ));
    });
  }
}
