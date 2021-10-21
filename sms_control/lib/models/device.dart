import 'dart:convert';

class Device {
  String? idKH, tenKH, diaChi, SDT;

  Device({this.idKH, this.tenKH, this.diaChi, this.SDT});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      idKH: json['idKH'],
      tenKH: json['tenKH'],
      diaChi: json['diaChi'],
      SDT: json['SDT'],
    );
  }

  factory Device.fromRawData(String jsonString) {
    return Device.fromJson(jsonDecode(jsonString));
  }

  String toRawData() {
    return jsonEncode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'idKH': this.idKH,
      'tenKH': this.tenKH,
      'diaChi': this.diaChi,
      'SDT': this.SDT,
    };
  }
}
