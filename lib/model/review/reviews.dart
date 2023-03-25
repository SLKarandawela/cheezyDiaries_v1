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