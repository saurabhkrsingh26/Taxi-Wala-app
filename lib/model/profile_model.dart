class ProfileModel {
  final String? id;
  final String? firstname;
  final String? address;
  final String? phone;
  final String? email;
  final String? dob;
  final String? gender;
  final String? wallet;
  final String? state;
  final String? datetime;
  final String? image;


  ProfileModel({
    this.id,
    this.firstname,
    this.address,
    this.phone,
    this.email,
    this.dob,
    this.gender,
    this.wallet,
    this.state,
    this.datetime,
    this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    print(json['id']);
    print("👍👍👍👍");
    return ProfileModel(
      id: json['id'],
      firstname: json['firstname'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      dob: json['dob'],
      gender: json['gender'],
      wallet: json['wallet'],
      state: json['state'],
      datetime: json['datetime'],
      image: json['image'],
    );
  }
}

