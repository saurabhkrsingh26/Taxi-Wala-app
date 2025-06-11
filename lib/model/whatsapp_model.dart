class WhatsappModel{

  String? id;
  String? whatsapp;


  WhatsappModel({
    this.id,
    this.whatsapp,


  });
  factory WhatsappModel.fromJson(Map<String, dynamic>json) => WhatsappModel(
    id: json["id"],
    whatsapp: json["whatsapp"],

  );
}
