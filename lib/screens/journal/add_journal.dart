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
Padding(

padding: const EdgeInsets.all(20.0),

child: Expanded(

child: SingleChildScrollView(

child: Column(

children: [

getMyField(

hintText: 'Overall Memory', controller: namecontroller),

DatePickerFormField(

hintText: 'Date', textEditingController: datecontroller),

getMyField(

hintText: 'Description', controller: desccontroller),

Padding(

padding: const EdgeInsets.only(top: 40),

child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

children: [

Container(

width: 130,

child: ElevatedButton(

onPressed: () {

JournalLog jLog = JournalLog(

logTitle: namecontroller.text,

logDate: datecontroller.text,

logDescription: desccontroller.text);

addLogAndNavigate(jLog, context);
BorderSide(color: Colors.green, width: 2.0),

),

),

),

),

),

Container(

width: 130,

child: ElevatedButton(

onPressed: () {

namecontroller.text = '';

datecontroller.text = '';
desccontroller.text = '';

},

child: const Text('Reset'),

style: ButtonStyle(

backgroundColor:

MaterialStateProperty.all<Color>(Colors.blue.shade300),

shape: MaterialStateProperty.all<

RoundedRectangleBorder>(

RoundedRectangleBorder(

  borderRadius: BorderRadius.circular(20.0),

side:

BorderSide(color: Colors.blue, width: 2.0),

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

bottomNavigationBar: BottomIconsWidget());

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

void addLogAndNavigate(JournalLog jLog, BuildContext context) {

// reference to firebase

final journalLogRef =

FirebaseFirestore.instance.collection('journal').doc();

jLog.id = journalLogRef.id;

final data = jLog.toJson();
journalLogRef.set(data).whenComplete(() {

Navigator.push(

context,

MaterialPageRoute(
  builder: (context) => LoadingPage(

nextPage: LogList(),

imageAsset: 'assets/images/health.png',

loadingText: 'Creating a log...',

),

));
});

}

}