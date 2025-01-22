import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
  ScanModel({
    this.id,
    this.tipus,
    required this.valor,
    this.title,
  }){
    if(this.valor.contains('http')){
      this.tipus = 'http';
    }else{
      this.tipus = 'geo';
    }
    if(this.title == null){
      this.title = 'Scan';
    }
  }

  int? id;
  String? tipus;
  String valor;
  String? title;

  LatLng getLatLng(){
    final latLng = this.valor.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);
    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
    id: json["id"],
    tipus: json["tipus"],
    valor: json["valor"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "tipus": tipus,
    "valor": valor,
    "title": title,
  };
}
