import 'package:cheezy_diaries/screens/home_page.dart';
import 'package:cheezy_diaries/screens/journal/logs_list.dart';
import 'package:cheezy_diaries/screens/recipie/recipie_list.dart';
import 'package:cheezy_diaries/screens/reviews/reviews_list.dart';
import 'package:cheezy_diaries/screens/workout/workout_list.dart';
import 'package:flutter/material.dart';

class BottomIconsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
          ),
          
            IconButton(
            icon: Icon(Icons.fastfood),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  RecipieList(),
                  ));
            },
          ),
      
          IconButton(
            icon: Icon(Icons.restaurant),
            onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ReviewList(),
                  ));
            },
          ),
              IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  WorkoutList(),
                  ));
            },
          ),
          IconButton(
            icon: Icon(Icons.description),
            onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  LogList(),
                  ));
            },
          ),
          
        
        ],
      ),
    );
  }
}
