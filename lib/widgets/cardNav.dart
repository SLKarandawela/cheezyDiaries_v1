import 'package:cheezy_diaries/screens/journal/logs_list.dart';
import 'package:cheezy_diaries/screens/recipie/add_recipie.dart';
import 'package:cheezy_diaries/screens/recipie/recipie_list.dart';
import 'package:cheezy_diaries/screens/workout/add_workout_log.dart';
import 'package:cheezy_diaries/screens/workout/workout_list.dart';
import 'package:flutter/material.dart';

import '../screens/reviews/add_review.dart';

class Dashboard extends StatelessWidget {
  final List<CardModel> _cards = [
    CardModel(label: 'My Diary',imagePath: 'images/diary.png', page: LogList(),),
    CardModel(label: 'Cook Book',imagePath: 'images/fry.png', page: RecipieList(),),
    CardModel(label: 'Food Hunt',imagePath: 'images/pizza.png', page: ReviewCreate(),),
    CardModel(label: 'Workouts',imagePath: 'images/schedule.png', page: WorkoutList(),),



    
       ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: GridView.count(
        crossAxisCount: 2,
        children: _cards.map((card) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => card.page),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/${card.imagePath}',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    card.label,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CardModel {
  final String label;
  final String imagePath;
  final Widget page;

  CardModel({
    required this.label,
    required this.imagePath,
    required this.page,
  });
}