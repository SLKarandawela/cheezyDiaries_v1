
import 'package:meta/meta.dart';
import 'dart:convert';

Recipie journalLogFromJson(String str) => Recipie.fromJson(json.decode(str));

String journalLogToJson(Recipie data) => json.encode(data.toJson());

//Recipe Class
class Recipie {
    Recipie({
        this.id,
        required this.recipieTitle,
        required this.ingrediants,
        required this.resDescription,
    });

    String? id;
    final String recipieTitle;
    final String ingrediants;
    final String resDescription;

    factory Recipie.fromJson(Map<String, dynamic> json) => Recipie(
        id: json["id"],
        recipieTitle: json["recipieTitle"],
        ingrediants: json["ingrediants"],
        resDescription: json["resDescription"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "recipieTitle": recipieTitle,
        "ingrediants": ingrediants,
        "resDescription": resDescription,
    };
}

