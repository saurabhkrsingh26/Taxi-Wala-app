class CarTypeModel{
  final String? id;
  final String? car_type;
  final String? price_km;
  final String? image;
  final String? status;
  final String? datetime;



  CarTypeModel({
    this.id,
    this.car_type,
    this.price_km,
    this.image,
    this.status,
    this.datetime,


  });

  factory CarTypeModel.fromJson(Map<String, dynamic> json) {
    return CarTypeModel(
      id: json['id'],
      car_type: json['car_type'],
      price_km: json['price_km'],
      image: json['image'],
      status: json['status'],
      datetime: json['datetime'],
    );
  }
}