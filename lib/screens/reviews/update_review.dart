import 'dart:math';
import 'package:cheezy_diaries/model/journal/my_journal.dart';
import 'package:cheezy_diaries/model/recipies/recipies.dart';
import 'package:cheezy_diaries/model/workout/workouts.dart';
import 'package:cheezy_diaries/screens/journal/logs_list.dart';
import 'package:cheezy_diaries/screens/reviews/reviews_list.dart';
import 'package:cheezy_diaries/widgets/date_picker.dart';
import 'package:cheezy_diaries/widgets/location_picker.dart';
import 'package:cheezy_diaries/widgets/numberInp.dart';
import 'package:flutter/material.dart';
import '../../model/review/reviews.dart';
import '../../widgets/emoji_inp.dart';
import '../../widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewUpdate extends StatelessWidget {
  final Review myReview;
  

  final TextEditingController reviewNamecontroller = TextEditingController();

  final TextEditingController restNamecontroller = TextEditingController();

  final TextEditingController reviewDesccontroller = TextEditingController();

  final TextEditingController reviewDatecontroller = TextEditingController();

  final TextEditingController _controller = TextEditingController();

  ReviewUpdate({super.key, required this.myReview});