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

class ReviewList extends StatelessWidget {

  final CollectionReference  _reference = FirebaseFirestore.instance.collection('review');
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
              // List<Review> reviews = documents.map((e) => JournalLog(id:e['id'],logTitle: e['logTitle'], logDate: e['logDate'], logDescription: e['logDescription'])).toList();
              List<Review> reviews = documents.map((e) => 
              Review(
                id:e['id'],
                restName: e['restName'],
                 reviewTitle: e['reviewTitle'],
                  reviewDate: e['reviewDate'],
                   reactionRange: e['reactionRange'],
                    reviewDesc: e['reviewDesc'])).toList();
              return _getBody(reviews);
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ReviewCreate(),));
    })),
  );
      
  }


  Widget _getBody(reviews) {
  return Expanded(
          child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(reviews[index].restName),
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
                         ReviewUpdate(myReview: reviews[index],)));
                    },),
                    InkWell(child: Icon(Icons.delete),onTap: () {
                      _reference.doc(reviews[index].id).delete();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ReviewList()));
                      
                    },)
                  ],
                )),
              ),
            ),
          ),

    
        );
}
}

