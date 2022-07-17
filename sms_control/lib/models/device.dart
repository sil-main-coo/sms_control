import 'dart:convert';

class Vehicle {
  String? ten, bienSo, sdt;

  Vehicle({this.ten, this.bienSo, this.sdt});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      ten: json['ten'],
      bienSo: json['bienSo'],
      sdt: json['sdt'],
    );
  }

  factory Vehicle.fromRawData(String jsonString) {
    return Vehicle.fromJson(jsonDecode(jsonString));
  }

  String toRawData() {
    return jsonEncode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'ten': this.ten,
      'bienSo': this.bienSo,
      'sdt': this.sdt,
    };
  }
}
