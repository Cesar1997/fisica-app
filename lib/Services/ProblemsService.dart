import 'package:fisica_app/Models/Levels.dart';
import 'package:fisica_app/Models/Problem.dart';
import 'dart:math';

class ProblemsService {


 static List<Problem> getAllProblemsFilteredBylevel(Levels level) {
      return [
        Problem(
          description: "Se deja caer una piedra desde la azotea de un edificio en un tiempo de 5.3 segundos ",
          height: null,
          initialVelocity: 0,
          level: parseLevel("easy"),
          velocity: null,
          time: 5.3,
          valuesToCalculate: [
            ValuesToCalculate(type: "height",selected: null),
            ValuesToCalculate(type : "velocity",selected: null)
          ]
        ),
        Problem(
          description: "Desde un edificio se deja caer una pelota, que tarda 8 segundos en llegar al piso. ¿con que velocidad impacta la pelota contra el piso?",
          height: null,
          velocity: null,
          initialVelocity: 0,
          level: parseLevel('easy'),
          time: 8,
          valuesToCalculate: [
            ValuesToCalculate(type : "velocity",selected: null)
          ]
        ),
        Problem(
          description: "Un objeto cae en caída libre y llega a una velocidad de 150 M/S. ¿Cuánto tiempo tardó en caer? ",
          height: null,
          initialVelocity: 0,
          level: parseLevel("easy"),
          velocity: 150,
          time: null,
          valuesToCalculate: 
          [
            ValuesToCalculate(type : "time",selected: null),
          ]
        ),
        
        Problem(
          description: "Una niña deja caer una muñeca desde una ventana que esta a 80 metros sobre el suelo",
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
        Problem(
          description: "¿Cuál es la velocidad final de un objeto que cae en caída libre, que parte del reposo y cae durante 10 segundos?",
          height: null,
          initialVelocity: 0,
          level: parseLevel("easy"),
          velocity: null,
          time: 10,
          valuesToCalculate: [
            ValuesToCalculate(type : "velocity",selected: null),
          ]
        )
      ];
  }

  static Future<Problem> getRandProblem(Levels level) async {
    var rng = new Random();
    final allProblems =  getAllProblemsFilteredBylevel(Levels.easy);
    int cantItems = allProblems.length - 1;
    int keySearch = rng.nextInt(cantItems);

    return allProblems[keySearch];
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