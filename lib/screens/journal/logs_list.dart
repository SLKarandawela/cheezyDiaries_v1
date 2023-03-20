import 'package:cheezy_diaries/model/journal/my_journal.dart';
import 'package:cheezy_diaries/screens/journal/add_journal.dart';
import 'package:cheezy_diaries/screens/journal/update_journal.dart';
import 'package:cheezy_diaries/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogList extends StatelessWidget {

  final CollectionReference  _reference = FirebaseFirestore.instance.collection('journal');

  // List <JournalLog> journalLogs = [
  //   JournalLog(id: "12345", logTitle: "First log", logDate: "3/20/23", logDescription: "sample description"),
  //   JournalLog(id: "12345", logTitle: "Second log", logDate: "3/20/23", logDescription: "sample description"),
  //   JournalLog(id: "12345", logTitle: "Third log", logDate: "3/20/23", logDescription: "sample description"),
  //   JournalLog(id: "12345", logTitle: "Fourth log", logDate: "3/20/23", logDescription: "sample description"),
  //   JournalLog(id: "12345", logTitle: "Fifth log", logDate: "3/20/23", logDescription: "sample description"),
  //   JournalLog(id: "12345", logTitle: "Sixth log", logDate: "3/20/23", logDescription: "sample description"),



  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: [
        const ScreenHeader(),
        FutureBuilder<QuerySnapshot>(
          future: _reference.get(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Center(child: Text("oops! something went wrong"),);
            }

            if(snapshot.hasData){
              QuerySnapshot querySnapshot = snapshot.data!;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;
              List<JournalLog> journalLogs = documents.map((e) => JournalLog(id:e['id'],logTitle: e['logTitle'], logDate: e['logDate'], logDescription: e['logDescription'])).toList();
              return _getBody(journalLogs);
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          // child: _getBody()
          ),
        
        
      ],
    ),

    floatingActionButton: FloatingActionButton(onPressed: ((){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const JournalCreate(),));
    })),
  );
      
  }
  
Widget _getBody(journalLogs) {
  return Expanded(
          child: ListView.builder(
            itemCount: journalLogs.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(journalLogs[index].logTitle),
                leading: const CircleAvatar(
                  radius: 25,
                ),
                trailing: SizedBox(
                  width: 60,
                  child: Row(
                  children: [
                    InkWell(child: Icon(Icons.edit),onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                         JournalUpdate(journalLog: journalLogs[index],)));
                    },),
                    InkWell(child: Icon(Icons.delete),onTap: () {
                      _reference.doc(journalLogs[index].id).delete();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LogList()));
                      
                    },)
                  ],
                )),
              ),
            ),
          ),

    
        );
}
}