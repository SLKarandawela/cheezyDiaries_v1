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

class ReviewCreate extends StatefulWidget {
  const ReviewCreate({super.key});

  @override
  State<ReviewCreate> createState() => _ReviewCreateState();
}

class _ReviewCreateState extends State<ReviewCreate> {
  final TextEditingController reviewNamecontroller = TextEditingController();
  final TextEditingController restNamecontroller = TextEditingController();
  final TextEditingController reviewDesccontroller = TextEditingController();
  final TextEditingController reviewDatecontroller = TextEditingController();
  final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        children:  [
          const ScreenHeader(title: "Create a review",),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  getMyField(hintText: 'Resturant name', controller: restNamecontroller),
                  getMyField(hintText: 'Review Header', controller: reviewNamecontroller),
                  getMyField(hintText: 'Review description', controller: reviewDesccontroller),
                  DatePickerFormField(hintText: "Visited at", textEditingController: reviewDatecontroller),
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
                            onPressed: (){
                              Review myReview = Review(restName: restNamecontroller.text,reviewTitle: reviewNamecontroller.text, reviewDate: reviewDatecontroller.text, reactionRange: int.parse(_controller.text), reviewDesc: reviewDesccontroller.text);
                              addReviewAndNavigate(myReview, context);
                        
                          }, 
                          child: const Text('Add'),style: ButtonStyle(
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
                                  ),),
                        ),    
                        
                        Container(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: (){
                              restNamecontroller.text = '';
                              reviewNamecontroller.text = '';
                              reviewDatecontroller.text = '';
                              reviewDesccontroller.text = '';
                              _controller.text = '';
                            
                          }, 
                          child: const Text('Reset'),style: ButtonStyle(
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
                                ),),
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

  Widget getMyField({required String hintText, required TextEditingController controller}){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter $hintText',labelText: hintText, border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))
          )
        ),
      ),
    );
  }
  
  void addReviewAndNavigate(Review mReview, BuildContext context) {
    // reference to firebase
    final wkRef = FirebaseFirestore.instance.collection('review').doc();
    mReview.id = wkRef.id;
    final data = mReview.toJson();
    wkRef.set(data).whenComplete((){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoadingPage(
              nextPage: ReviewList(),
              imageAsset: 'assets/images/health.png',
              loadingText: 'Creating a review...',
            ),));
    });
  }



}