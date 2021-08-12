import 'dart:convert';

List<Stations> stationsFromJson(String str) =>
    List<Stations>.from(json.decode(str).map((x) => Stations.fromMap(x)));
String stationsToJson(List<Stations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Stations {
  String station_id;
  String station;
  String longitude;
  String latitude;

  Stations({
    this.station_id,
    this.station,
    this.longitude,
    this.latitude,
  });

  factory Stations.fromMap(Map<String, dynamic> json) => Stations(
        station_id: json["station_id"],
        station: json["station"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toMap() => {
        "station_id": station_id,
        "station": station,
        "longitude": longitude,
        "latitude": latitude,
      };
}
