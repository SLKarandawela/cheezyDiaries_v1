import 'package:cheezy_diaries/model/journal/my_journal.dart';
import 'package:cheezy_diaries/screens/journal/add_journal.dart';
import 'package:cheezy_diaries/screens/journal/update_journal.dart';
import 'package:cheezy_diaries/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/confirmation_dialog.dart';

class LogList extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('journal');

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
              if (snapshot.hasError) {
                return const Center(
                  child: Text("oops! something went wrong"),
                );
              }

              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data!;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                List<JournalLog> journalLogs = documents
                    .map((e) => JournalLog(
                        id: e['id'],
                        logTitle: e['logTitle'],
                        logDate: e['logDate'],
                        logDescription: e['logDescription']))
                    .toList()
                  ..sort((a, b) => b.logDate.compareTo(a.logDate));
                return _getBody(journalLogs);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            // child: _getBody()
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JournalCreate(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  TextStyle headerTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  Widget _getBody(journalLogs) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: journalLogs.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // Add the same border radius to the container
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Choose your desired color
                    spreadRadius: 2, // The spread radius of the shadow
                    blurRadius: 5, // The blur radius of the shadow
                    offset: Offset(0, 3), // The position of the shadow
                  ),
                ],
              ),
              child: Card(
                elevation: 4, // This will add a default shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Add a border radius to the card
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      journalLogs[index].logTitle,
                      style: headerTextStyle,
                    ),
                    subtitle: Text(journalLogs[index].logDate),
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/fry.png'),
                    ),
                    trailing: SizedBox(
                        width: 60,
                        child: Row(
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue.shade400,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JournalUpdate(
                                              journalLog: journalLogs[index],
                                            )));
                              },
                            ),
                            InkWell(
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmationDialog(
                                      title: 'Confirm Deletion',
                                      message:
                                          'Are you sure you want to delete this item?',
                                      onConfirm: () {
                                        _reference
                                            .doc(journalLogs[index].id)
                                            .delete();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => LogList()),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      
    );
    
  }
}
