import 'dart:convert';

EditProfiles editProfileFromJson(String str) => EditProfiles.fromJson(json.decode(str));

String editProfilesToJson(EditProfiles data) => json.encode(data.toJson());

class EditProfiles {
  EditProfiles({
    this.name,
    this.email,
    this.address,
    this.phonenumber,
    this.image,
  });

  String? name;
  String? email;
  String? address;
  String? phonenumber;
  String? image;

  factory EditProfiles.fromJson(Map<String, dynamic> json) => EditProfiles(
    name: json["name"],
    email: json["email"],
    address: json["address"],
    phonenumber: json["phonenumber"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "address": address,
    "phonenumber": phonenumber,
    "image": image,
  };
}