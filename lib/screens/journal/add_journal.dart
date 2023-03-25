import 'dart:math';

import 'package:cheezy_diaries/model/journal/my_journal.dart';

import 'package:cheezy_diaries/screens/journal/logs_list.dart';

import 'package:cheezy_diaries/widgets/bottom_icons.dart';

import 'package:cheezy_diaries/widgets/date_picker.dart';

import 'package:cheezy_diaries/widgets/location_picker.dart';

import 'package:flutter/material.dart';
import '../../widgets/header.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/loader_navigator.dart';

class JournalCreate extends StatefulWidget {

const JournalCreate({super.key});
@override

State<JournalCreate> createState() => _JournalCreateState();

}

class _JournalCreateState extends State<JournalCreate> {

final TextEditingController namecontroller = TextEditingController();

final TextEditingController datecontroller = TextEditingController();

final TextEditingController desccontroller = TextEditingController();
@override

Widget build(BuildContext context) {

return Scaffold(

body: Column(

children: [

const ScreenHeader(

title: "Create new log",

),