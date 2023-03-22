import 'package:meta/meta.dart';
import 'dart:convert';

Workout workoutFromJson(String str) => Workout.fromJson(json.decode(str));

String workoutToJson(Workout data) => json.encode(data.toJson());

class Workout {
    Workout({
        this.id,
        required this.workoutFeedback,
        required this.workoutComment,
        required this.wDate,
        required this.jumpingJackCount,
        required this.pushUpCount,
        required this.squatsCount,

    });

    String? id;
    final String workoutFeedback;
    final String workoutComment;
    final String wDate;
    final int jumpingJackCount;
    final int pushUpCount;
    final int squatsCount;




    factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json["id"],
        workoutFeedback: json["workoutFeedback"],
        workoutComment: json["workoutComment"],
        wDate: json["wDate"],
        jumpingJackCount: json["jumpingJackCount"],
        pushUpCount: json["pushUpCount"],
        squatsCount: json["squatsCount"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "workoutFeedback": workoutFeedback,
        "workoutComment": workoutComment,
        "wDate":wDate,
        "jumpingJackCount": jumpingJackCount,
        "pushUpCount": pushUpCount,
        "squatsCount": squatsCount,

    };
}
