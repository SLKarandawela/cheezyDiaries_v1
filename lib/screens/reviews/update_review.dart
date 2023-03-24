import 'dart:math';
import 'package:cheezy_diaries/model/journal/my_journal.dart';
import 'package:cheezy_diaries/model/recipies/recipies.dart';
import 'package:cheezy_diaries/model/workout/workouts.dart';
import 'package:cheezy_diaries/screens/journal/logs_list.dart';
import 'package:cheezy_diaries/screens/reviews/reviews_list.dart';
import 'package:cheezy_diaries/widgets/date_picker.dart';
import 'package:cheezy_diaries/widgets/location_picker.dart';
import 'package:cheezy_diaries/widgets/numberInp.dart';
import 'package:flutter/material.dart';
import '../../model/review/reviews.dart';
import '../../widgets/bottom_icons.dart';
import '../../widgets/emoji_inp.dart';
import '../../widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/loader_navigator.dart';

class ReviewUpdate extends StatelessWidget {
  final Review myReview;

  final TextEditingController reviewNamecontroller = TextEditingController();

  final TextEditingController restNamecontroller = TextEditingController();

  final TextEditingController reviewDesccontroller = TextEditingController();

  final TextEditingController reviewDatecontroller = TextEditingController();

  final TextEditingController _controller = TextEditingController();

  ReviewUpdate({super.key, required this.myReview});

  @override
  Widget build(BuildContext context) {
    restNamecontroller.text = myReview.restName;
    reviewNamecontroller.text = myReview.reviewTitle;
    reviewDatecontroller.text = myReview.reviewDate;
    reviewDesccontroller.text = myReview.reviewDesc;
    _controller.text = '${myReview.reactionRange}';
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        children: [
          const ScreenHeader(
            title: "Update a review",
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  getMyField(
                      hintText: 'Resturant name', controller: restNamecontroller),
                  getMyField(
                      hintText: 'Review Header',
                      controller: reviewNamecontroller),
                  getMyField(
                      hintText: 'Review description',
                      controller: reviewDesccontroller),
                  DatePickerFormField(
                      hintText: "Visited at",
                      textEditingController: reviewDatecontroller),
                  EmojiButtonWidget(
                    iconData1: Icons.thumb_up,
                    iconData2: Icons.thumb_down,
                    controller: _controller,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              Review updatedReview = Review(
                                  id: myReview.id,
                                  restName: restNamecontroller.text,
                                  reviewTitle: reviewNamecontroller.text,
                                  reviewDate: reviewDatecontroller.text,
                                  reactionRange: int.parse(_controller.text),
                                  reviewDesc: reviewDesccontroller.text);
                              
                              final CollectionReference =
                                  FirebaseFirestore.instance.collection('review');
                              CollectionReference.doc(updatedReview.id)
                                  .update(updatedReview.toJson())
                                  .whenComplete(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoadingPage(
                                        nextPage: ReviewList(),
                                        imageAsset: 'assets/images/health.png',
                                        loadingText: 'updating a review...',
                                      ),));
                              });
                            },
                            child: const Text('Update'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green.shade400),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.green, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              restNamecontroller.text = '';
                              reviewNamecontroller.text = '';
                              reviewDatecontroller.text = '';
                              reviewDesccontroller.text = '';
                              _controller.text = '';
                            },
                            child: const Text('Reset'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue.shade300),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.blue, width: 2.0),
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
