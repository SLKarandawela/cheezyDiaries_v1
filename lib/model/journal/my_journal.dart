mport 'package:meta/meta.dart';

import 'dart:convert';

JournalLog journalLogFromJson(String str) => JournalLog.fromJson(json.decode(str));

String journalLogToJson(JournalLog data) => json.encode(data.toJson());

class JournalLog {

JournalLog({

this.id,
required this.logTitle,

required this.logDate,

required this.logDescription,

});

String? id;

final String logTitle;

final String logDate;

final String logDescription;

factory JournalLog.fromJson(Map<String, dynamic> json) => JournalLog(

id: json["id"],
logTitle: json["logTitle"],

logDate: json["logDate"],

logDescription: json["logDescription"],

);