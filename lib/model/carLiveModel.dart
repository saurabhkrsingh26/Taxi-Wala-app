class CarLiveModel{
  final String? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? wallet;
  final String? latitude;
  final String? longitude;
  final String? live_status;
  final String? car_type_id;
  final String? status;
  final String? datetime;
  final String? userstatus;
  final String? current_address;


  CarLiveModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.wallet,
    this.latitude,
    this.longitude,
    this.live_status,
    this.car_type_id,
    this.status,
    this.datetime,
    this.userstatus,
    this.current_address,



  });

  factory CarLiveModel.fromJson(Map<String, dynamic> json) {
    return CarLiveModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      wallet: json['wallet'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      live_status: json['live_status'],
      car_type_id: json['car_type_id'],
      status: json['status'],
      datetime: json['datetime'],
      userstatus: json['userstatus'],
      current_address: json['current_address'],
    );
  }
}



