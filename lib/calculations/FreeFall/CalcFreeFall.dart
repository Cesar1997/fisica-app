import 'dart:math';

import 'package:fisica_app/Models/Problem.dart';

class CalcFreeFall {
  Problem problem;
  final GRAVITY = 9.8;

  CalcFreeFall(Problem problem) {
    this.problem = problem;
  }
  double calcTime() {
    if(this.problem.time != null) {
      return this.problem.time;
    }
    return sqrt( ( 2 * this.calcHeight() ) / this.GRAVITY );
  }

  double calcHeight() {
    if(this.problem.height != null) {
      return this.problem.height;
    }
    double wather = this.problem.time != null ? this.problem.time : this.calcTime();
    return (this.GRAVITY * pow(wather, 2) / 2);  
  }

  double calcVelocity() {
    return this.GRAVITY * this.calcTime();
  }

  List<Map> createListForTimeWithValuesRandomAndValueThurt() {
      final List<Map> listRandom = [];
      double time =  this.calcTime();
      listRandom.add({'value':time, 'isResponse' : false  });
      var rng = new Random();
      for(var i = 0; i< 3; i++) {
        final findRand = rng.nextDouble() * time;
        listRandom.add({'value':findRand, 'isResponse' : false  });
      }
      return listRandom;
  }
  
  List<Map> createListForVelocityWithValuesRandomAndValueThurt() {
      final List<Map> listRandom = [];
      double time =  this.calcVelocity();
      listRandom.add({'value':time, 'isResponse' : false  });
      var rng = new Random();
      for(var i = 0; i< 3; i++) {
        final findRand = rng.nextDouble() * time;
        listRandom.add({'value':findRand, 'isResponse' : false  });
      }
      return listRandom;
  }

  
  List<Map> createListForHeigthWithValuesRandomAndValueThurt() {
      final List<Map> listRandom = [];
      double time =  this.calcHeight();
      listRandom.add({'value':time, 'isResponse' : false  });
      var rng = new Random();
      for(var i = 0; i< 3; i++) {
        final findRand = rng.nextDouble() * time;
        listRandom.add({'value':findRand, 'isResponse' : false  });
      }
      return listRandom;
  }



}