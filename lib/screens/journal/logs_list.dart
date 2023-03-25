import 'package:cheezy_diaries/model/journal/my_journal.dart';

import 'package:cheezy_diaries/screens/journal/add_journal.dart';

import 'package:cheezy_diaries/screens/journal/update_journal.dart';

import 'package:cheezy_diaries/widgets/bottom_icons.dart';

import 'package:cheezy_diaries/widgets/header.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/placeholder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/confirmation_dialog.dart';

class LogList extends StatelessWidget {

final CollectionReference _reference =

FirebaseFirestore.instance.collection('journal');
// ];
// List <JournalLog> journalLogs = [

//   JournalLog(id: "12345", logTitle: "First log", logDate: "3/20/23", logDescription: "sample description"),

//   JournalLog(id: "12345", logTitle: "Second log", logDate: "3/20/23", logDescription: "sample description"),

//   JournalLog(id: "12345", logTitle: "Third log", logDate: "3/20/23", logDescription: "sample description"),

//   JournalLog(id: "12345", logTitle: "Fourth log", logDate: "3/20/23", logDescription: "sample description"),

//   JournalLog(id: "12345", logTitle: "Fifth log", logDate: "3/20/23", logDescription: "sample description"),

//   JournalLog(id: "12345", logTitle: "Sixth log", logDate: "3/20/23", logDescription: "sample description"),

// ];
@override

Widget build(BuildContext context) {

return Scaffold(

body: Column(

children: [

const ScreenHeader(title: "My logs"),
FutureBuilder<QuerySnapshot>(

future: _reference.get(),

builder: (context, snapshot) {

if (snapshot.hasError) {

return const Center(

child: Text("oops! something went wrong"),

);