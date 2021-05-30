// To parse this JSON data, do
//
//     final problem = problemFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Problem problemFromJson(String str) => Problem.fromJson(json.decode(str));

String problemToJson(Problem data) => json.encode(data.toJson());

class Problem {
    Problem({
        this.description,
        this.height,
        this.time,
        this.velocity,
        this.initialVelocity,
        this.valuesToCalculate,
        this.level,
    });

    String description;
    double height;
    double time;
    double velocity;
    double initialVelocity;
    List<ValuesToCalculate> valuesToCalculate;
    String level;

    factory Problem.fromJson(Map<String, dynamic> json) => Problem(
        description: json["problem"],
        height: json["height"].toDouble(),
        time: json["time"].toDouble(),
        velocity: json["velocity"].toDouble(),
        initialVelocity: json["initialVelocity"].toDouble(),
        valuesToCalculate: List<ValuesToCalculate>.from(json["valuesToCalculate"].map((x) => ValuesToCalculate.fromJson(x))),
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "problem": description,
        "height": height,
        "time": time,
        "velocity": velocity,
        "initialVelocity": initialVelocity,
        "valuesToCalculate": List<dynamic>.from(valuesToCalculate.map((x) => x.toJson())),
        "level": level,
    };
}

class ValuesToCalculate {
    ValuesToCalculate({
        this.type,
        this.selected,
    });

    String type;
    Selected selected;

    factory ValuesToCalculate.fromJson(Map<String, dynamic> json) => ValuesToCalculate(
        type: json["type"],
        selected: Selected.fromJson(json["selected"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "selected": selected.toJson(),
    };
}

class Selected extends Equatable {
    Selected({
        this.value,
        this.isResponse,
    });

    String value;
    bool isResponse;

    factory Selected.fromJson(Map<String, dynamic> json) => Selected(
        value: json["value"].toDouble(),
        isResponse: json["isResponse"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "isResponse": isResponse,
    };

  @override
  // TODO: implement props
  List<Object> get props => [value,isResponse];
}
