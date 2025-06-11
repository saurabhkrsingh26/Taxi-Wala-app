class UserModel{

  String? userid;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? dob;

  UserModel({
    this.userid,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.dob,

  });
  factory UserModel.fromJson(Map<String, dynamic>json) => UserModel(
    userid: json["userid"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    gender: json["gender"],
    dob: json["dob"],
  );
}
