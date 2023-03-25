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

import '../../widgets/bottom_icons.dart';
import '../../widgets/confirmation_dialog.dart';

class WorkoutList extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('workout');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(
            title: "My workouts",
          ),
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
                List<Workout> workouts = documents
                    .map((e) => Workout(
                        id: e['id'],
                        workoutFeedback: e['workoutFeedback'],
                        workoutComment: e['workoutComment'],
                        wDate: e['wDate'],
                        jumpingJackCount: e['jumpingJackCount'],
                        pushUpCount: e['pushUpCount'],
                        squatsCount: e['squatsCount']))
                    .toList()
                    ..sort((a, b) => b.wDate.compareTo(a.wDate));
                return _getBody(workouts);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            // child: _getBody()
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WorkoutCreate(),
              ));
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


  Widget _getBody(workouts) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // Add the same border radius to the container
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Choose your desired color
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
                    title: Text(workouts[index].workoutFeedback, style: headerTextStyle),
                    subtitle: Text(workouts[index].wDate),
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/fitness.png'),
                    ),
                    trailing: SizedBox(
                        width: 60,
                        child: Row(
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue.shade400,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkoutEdit(
                                              workoutLog: workouts[index],
                                            )));
                              },
                            ),
                            InkWell(
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
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
                                            .doc(workouts[index].id)
                                            .delete();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => WorkoutList()),
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
      ),
    );
  }
}
