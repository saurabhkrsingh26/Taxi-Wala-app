class AuthModel {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? address;
  final String? phone;
  final String? email;
  final String? wallet;
  final String? state;
  final String? referral_code;
  final String? datetime;
  final String? image;


  AuthModel({
    this.id,
    this.firstname,
    this.lastname,
    this.address,
    this.phone,
    this.email,
    this.wallet,
    this.state,
    this.referral_code,
    this.datetime,
    this.image,

  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
       id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      wallet: json['wallet'],
      state: json['state'],
      referral_code: json['referral_code'],
      datetime: json['datetime'],
      image: json['image'],


    );
  }
}