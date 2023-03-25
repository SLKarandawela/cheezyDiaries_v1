import 'package:cheezy_diaries/model/journal/my_journal.dart';
import 'package:cheezy_diaries/model/review/reviews.dart';
import 'package:cheezy_diaries/screens/journal/add_journal.dart';
import 'package:cheezy_diaries/screens/journal/update_journal.dart';
import 'package:cheezy_diaries/screens/reviews/add_review.dart';
import 'package:cheezy_diaries/screens/reviews/update_review.dart';
import 'package:cheezy_diaries/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/bottom_icons.dart';
import '../../widgets/confirmation_dialog.dart';

class ReviewList extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('review');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(
            title: "Review List",
          ),
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
                // List<Review> reviews = documents.map((e) => JournalLog(id:e['id'],logTitle: e['logTitle'], logDate: e['logDate'], logDescription: e['logDescription'])).toList();
                List<Review> reviews = documents
                    .map((e) => Review(
                        id: e['id'],
                        restName: e['restName'],
                        reviewTitle: e['reviewTitle'],
                        reviewDate: e['reviewDate'],
                        reactionRange: e['reactionRange'],
                        reviewDesc: e['reviewDesc']))
                    .toList()
                    ..sort((a, b) => b.reviewDate.compareTo(a.reviewDate));
                return _getBody(reviews);
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
                builder: (context) => const ReviewCreate(),
              ));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomIconsWidget(),
    );
  }

  TextStyle headerTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  Widget _getBody(reviews) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
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
                    title:
                        Text(reviews[index].restName, style: headerTextStyle),
                    subtitle: Text(reviews[index].reviewTitle),
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/cuisine.png'),

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
                                        builder: (context) => ReviewUpdate(
                                              myReview: reviews[index],
                                            )));
                              },
                            ),
                            InkWell(
                              child: Icon(
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
                                            .doc(reviews[index].id)
                                            .delete();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => ReviewList()),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            )
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
