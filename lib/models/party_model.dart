// To parse this JSON data, do
//
//     final partyModel = partyModelFromJson(jsonString);

import 'dart:convert';

PartyModel partyModelFromJson(String str) =>
    PartyModel.fromJson(json.decode(str));

String partyModelToJson(PartyModel data) => json.encode(data.toJson());

class PartyModel {
  PartyModel({
    this.imageUrl,
    this.memberList,
    required this.host,
    required this.memberMax,
    required this.title,
    this.join,
  });

  String? imageUrl;
  List<String>? memberList;
  String host;
  int memberMax;
  String title;
  bool? join;

  factory PartyModel.fromJson(Map<String, dynamic> json) => PartyModel(
        imageUrl: json["image_url"],
        memberList: json["member_list"] != null
            ? List<String>.from(json["member_list"].map((x) => x))
            : [],
        host: json["host"],
        memberMax: json["member_max"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "member_list": memberList != null
            ? List<dynamic>.from(memberList!.map((x) => x))
            : [],
        "host": host,
        "member_max": memberMax,
        "title": title,
      };
}
