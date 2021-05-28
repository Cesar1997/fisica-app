// To parse this JSON data, do
//
//     final problem = problemFromJson(jsonString);

import 'dart:convert';

Problem problemFromJson(String str) => Problem.fromJson(json.decode(str));

String problemToJson(Problem data) => json.encode(data.toJson());

class Problem {
    Problem({
        this.problem,
        this.height,
        this.time,
        this.velocity,
        this.initialVelocity,
        this.valuesToCalculate,
        this.level,
    });

    String problem;
    double height;
    double time;
    double velocity;
    double initialVelocity;
    List<String> valuesToCalculate;
    String level;

    factory Problem.fromJson(Map<String, dynamic> json) => Problem(
        problem: json["problem"],
        height: json["height"],
        time: json["time"],
        velocity: json["velocity"],
        initialVelocity: json["initialVelocity"],
        valuesToCalculate: List<String>.from(json["valuesToCalculate"].map((x) => x)),
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "problem": problem,
        "height": height,
        "time": time,
        "velocity": velocity,
        "initialVelocity": initialVelocity,
        "valuesToCalculate": List<dynamic>.from(valuesToCalculate.map((x) => x)),
        "level": level,
    };
}
