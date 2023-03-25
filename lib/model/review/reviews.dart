import 'package:meta/meta.dart';
import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
    Review({
        this.id,
        required this.restName,
        required this.reviewTitle,
        required this.reviewDate,
        required this.reactionRange,
        required this.reviewDesc,
   

    });

    String? id;
    final String restName;
    final String reviewTitle;
    final String reviewDate;
    final String reviewDesc;
    final int reactionRange;
    




    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        restName: json["restName"],
        reviewTitle: json["reviewTitle"],
        reviewDate: json["reviewDate"],
        reviewDesc: json["reviewDesc"],
        reactionRange: json["reactionRange"]

    );


    Map<String, dynamic> toJson() => {
        "id": id,
        "restName": restName,
        "reviewTitle": reviewTitle,
        "reviewDate": reviewDate,
        "reviewDesc":reviewDesc,
        "reactionRange": reactionRange

    };
}

