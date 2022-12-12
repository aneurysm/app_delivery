import 'dart:convert';

GoogleGeoLocation googleGeoLocationFromMap(String str) =>
    GoogleGeoLocation.fromMap(json.decode(str));

String googleGeoLocationToMap(GoogleGeoLocation data) =>
    json.encode(data.toMap());

class GoogleGeoLocation {
  GoogleGeoLocation({
    this.results,
    this.status,
  });

  List<Result>? results;
  String? status;

  factory GoogleGeoLocation.fromMap(Map<String, dynamic> json) =>
      GoogleGeoLocation(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
        "status": status,
      };
}

class Result {
  Result({
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.types,
  });

  String formattedAddress;
  Geometry geometry;
  String placeId;
  List<String> types;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromMap(json["geometry"]),
        placeId: json["place_id"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "formatted_address": formattedAddress,
        "geometry": geometry.toMap(),
        "place_id": placeId,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    required this.location,
    required this.locationType,
  });

  Location location;
  String locationType;

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        location: Location.fromMap(json["location"]),
        locationType: json["location_type"],
      );

  Map<String, dynamic> toMap() => {
        "location": location.toMap(),
        "location_type": locationType,
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}
