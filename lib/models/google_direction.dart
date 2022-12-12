import 'dart:convert';

String googleDirectionToMap(GoogleDirection data) => json.encode(data.toMap());

List<GoogleDirection> googleDirectionFromMap(String str) =>
    List<GoogleDirection>.from(
        json.decode(str).map((x) => GoogleDirection.fromMap(x)));

class GoogleDirection {
  GoogleDirection({
    required this.predictions,
    required this.status,
  });

  List<Prediction> predictions;
  String status;

  factory GoogleDirection.fromJson(String str) =>
      GoogleDirection.fromMap(json.decode(str));

  factory GoogleDirection.fromMap(Map<String, dynamic> json) => GoogleDirection(
        predictions: List<Prediction>.from(
            json["predictions"].map((x) => Prediction.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "predictions": List<dynamic>.from(predictions.map((x) => x.toMap())),
        "status": status,
      };
}

class Prediction {
  Prediction({
    required this.description,
    required this.placeId,
    required this.structuredFormatting,
    required this.terms,
  });

  String description;
  String placeId;
  StructuredFormatting structuredFormatting;
  List<Term> terms;

  factory Prediction.fromMap(Map<String, dynamic> json) => Prediction(
        description: json["description"],
        placeId: json["place_id"],
        structuredFormatting:
            StructuredFormatting.fromMap(json["structured_formatting"]),
        terms: List<Term>.from(json["terms"].map((x) => Term.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "place_id": placeId,
        "structured_formatting": structuredFormatting.toMap(),
        "terms": List<dynamic>.from(terms.map((x) => x.toMap())),
      };
}

class StructuredFormatting {
  StructuredFormatting({
    required this.mainText,
    required this.secondaryText,
  });

  String mainText;
  String secondaryText;

  factory StructuredFormatting.fromMap(Map<String, dynamic> json) =>
      StructuredFormatting(
        mainText: json["main_text"],
        secondaryText: json["secondary_text"],
      );

  Map<String, dynamic> toMap() => {
        "main_text": mainText,
        "secondary_text": secondaryText,
      };
}

class Term {
  Term({
    required this.offset,
    required this.value,
  });

  int offset;
  String value;

  factory Term.fromMap(Map<String, dynamic> json) => Term(
        offset: json["offset"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "offset": offset,
        "value": value,
      };
}
