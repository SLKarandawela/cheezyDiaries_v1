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