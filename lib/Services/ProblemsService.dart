import 'package:fisica_app/Models/Levels.dart';
import 'package:fisica_app/Models/Problem.dart';

class ProblemsService {


 static List<Problem> getAllProblemsFilteredBylevel(Levels level) {
      return [
        Problem(
          problem: "Se deja caer una piedra desde la azotea de un edificio ",
          height: null,
          initialVelocity: 0,
          level: parseLevel("easy"),
          velocity: null,
          time: 5.3,
          valuesToCalculate: 
          [
            ValuesToCalculate(type: "height",selected: null),
            ValuesToCalculate(type : "velocity",selected: null)
          ]
        ),
        Problem(
          problem: "Una niña deja caer una muñeca desde una ventana que esta a 80 metros sobre el suelo",
          height: 80,
          initialVelocity: 0,
          level: parseLevel("easy"),
          velocity: null,
          time: null,
          valuesToCalculate: [
            ValuesToCalculate(type : "time",selected: null),
            ValuesToCalculate(type : "velocity",selected: null),
          ]
        ),
      ];
  }

  static Future<Problem> getRandProblem(Levels level) async {
    return getAllProblemsFilteredBylevel(Levels.easy)[1];
  }

  static String parseLevel(String level) {
    switch(level) {
      case "easy" :
        return "Fácil";
      break;
      case "medium" :
        return "Medio";
      break;
      case "hard" : 
        return "Díficil";
      break;
    }
  }
}