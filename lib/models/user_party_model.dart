// To parse this JSON data, do
//
//     final partyModel = partyModelFromJson(jsonString);

import 'dart:convert';

UserPartyModel partyModelFromJson(String str) =>
    UserPartyModel.fromJson(json.decode(str));

String partyModelToJson(UserPartyModel data) => json.encode(data.toJson());

class UserPartyModel {
  UserPartyModel({
    this.partyList,
    this.partyCreate,
  });

  List<String>? partyList;
  List<String>? partyCreate;

  factory UserPartyModel.fromJson(Map<String, dynamic> json) => UserPartyModel(
        partyList: json["party_list"] != null
            ? List<String>.from(json["party_list"].map((x) => x))
            : [],
        partyCreate: json["party_create"] != null
            ? List<String>.from(json["party_create"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "party_list": partyList != null
            ? List<dynamic>.from(partyList!.map((x) => x))
            : [],
        "party_create": partyCreate != null
            ? List<dynamic>.from(partyCreate!.map((x) => x))
            : [],
      };
}
