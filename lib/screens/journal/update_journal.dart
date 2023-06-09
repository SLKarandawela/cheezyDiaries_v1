import 'package:cheezy_diaries/model/journal/my_journal.dart';

import 'package:cheezy_diaries/screens/journal/logs_list.dart';

import 'package:cheezy_diaries/widgets/date_picker.dart';

import 'package:cheezy_diaries/widgets/location_picker.dart';

import 'package:flutter/material.dart';

import '../../widgets/bottom_icons.dart';

import '../../widgets/header.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/loader_navigator.dart';

class JournalUpdate extends StatelessWidget {

final JournalLog journalLog;

final TextEditingController namecontroller = TextEditingController();

final TextEditingController datecontroller = TextEditingController();

final TextEditingController desccontroller = TextEditingController();

JournalUpdate({super.key, required this.journalLog});
@override

Widget build(BuildContext context) {

namecontroller.text = journalLog.logTitle;

datecontroller.text = journalLog.logDate;

desccontroller.text = journalLog.logDescription;

return Scaffold(

body: Column(

children: [

const ScreenHeader(

title: "Update log",

),

Padding(

padding: const EdgeInsets.only(top: 40, left: 20, right: 20),

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

JournalLog updatedLog = JournalLog(

id: journalLog.id,

logTitle: namecontroller.text,

logDate: datecontroller.text,

logDescription: desccontroller.text);

final CollectionReference = FirebaseFirestore

.instance

.collection('journal');
Container(

width: 130,

child: ElevatedButton(

onPressed: () {

JournalLog updatedLog = JournalLog(

id: journalLog.id,

logTitle: namecontroller.text,

logDate: datecontroller.text,

logDescription: desccontroller.text);

final CollectionReference = FirebaseFirestore

.instance

.collection('journal');
CollectionReference.doc(updatedLog.id)

.update(updatedLog.toJson())

.whenComplete(() {

Navigator.push(

context,

MaterialPageRoute(

builder: (context) => LoadingPage(

nextPage: LogList(),

imageAsset: 'assets/images/health.png',

loadingText: 'updating a log...',

),

));
});

},

child: const Text('Update'),

style: ButtonStyle(

backgroundColor:

MaterialStateProperty.all<Color>(Colors.green.shade400),

shape: MaterialStateProperty.all<

RoundedRectangleBorder>(

RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20.0),

side:

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

}
