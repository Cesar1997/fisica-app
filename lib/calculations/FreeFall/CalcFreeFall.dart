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
    if(this.problem.velocity != null) {
      return this.problem.velocity;
    }
    return this.GRAVITY * this.calcTime();
  }

  List<Selected> createListForTimeWithValuesRandomAndValueThurt() {
      final List<Selected> listRandom = [];
      double time =  this.calcTime();
      
      listRandom.add(Selected(value: "seleccione",isResponse: false ));
      listRandom.add(Selected(value: time.toStringAsFixed(2),isResponse: true ));
      var rng = new Random();
      for(var i = 0; i< 3; i++) {
        final findRand = rng.nextDouble() * time;
        listRandom.add( Selected(value: findRand.toStringAsFixed(2),isResponse: false ) );
      }

      Selected selected = this.problem.valuesToCalculate.firstWhere((element) => element.type == 'time').selected;
      if(selected != null){
        bool verifyExists = listRandom.where((element) => element.value == selected.value).isNotEmpty;

        if(!verifyExists) {
          Selected elementToRemove =  listRandom.firstWhere((element)  {
              return !element.isResponse  && element.value != "seleccione";
          });
          listRandom.removeWhere((item) => item.value == elementToRemove.value);
          listRandom.add(selected);
        }
      }
      
      return listRandom;
  }
  
  List<Selected> createListForVelocityWithValuesRandomAndValueThurt() {
      final List<Selected> listRandom = [];
      double time =  this.calcVelocity();
      listRandom.add(Selected(value: "seleccione",isResponse: false ));
      listRandom.add( Selected(value: time.toStringAsFixed(2),isResponse: true ) );
      var rng = new Random();
      for(var i = 0; i< 3; i++) {
        final findRand = rng.nextDouble() * time;
        listRandom.add( Selected(value: findRand.toStringAsFixed(2),isResponse: false ) );
      }
      
      Selected selected = this.problem.valuesToCalculate.firstWhere((element) => element.type == 'velocity').selected;
      
      if(selected != null) { 
        bool verifyExists = listRandom.where((element) => element.value == selected.value).isNotEmpty;
        if(!verifyExists) {
          Selected elementToRemove =  listRandom.firstWhere((element)  {
              return !element.isResponse  && element.value != "seleccione";
          });
          listRandom.removeWhere((item) => item.value == elementToRemove.value);
          listRandom.add(selected);
        }
      }

      return listRandom;

  }

  
  List<Selected> createListForHeigthWithValuesRandomAndValueThurt() {
      final List<Selected> listRandom = [];
      double time =  this.calcHeight();
      listRandom.add(Selected(value: "seleccione",isResponse: false ));
      listRandom.add( Selected(value: time.toStringAsFixed(2),isResponse: true ));
      var rng = new Random();
      for(var i = 0; i< 3; i++) {
        final findRand = rng.nextDouble() * time;
        listRandom.add( Selected(value: findRand.toStringAsFixed(2),isResponse: false ));
      }
       Selected selected = this.problem.valuesToCalculate.firstWhere((element) => element.type == 'height').selected;
       if(selected != null) {
         bool verifyExists = listRandom.where((element) => element.value == selected.value).isNotEmpty;
         
        if(!verifyExists) {
          Selected elementToRemove =  listRandom.firstWhere((element)  {
              return !element.isResponse  && element.value != "seleccione";
          });
          listRandom.removeWhere((item) => item.value == elementToRemove.value);
          listRandom.add(selected);
        }
      }

      return listRandom;
  }



}