import 'dart:convert';

import 'package:fisica_app/Models/Levels.dart';
import 'package:fisica_app/Services/ProblemsService.dart';
import 'package:fisica_app/calculations/FreeFall/CalcFreeFall.dart';
import 'package:flutter/material.dart';
import 'package:fisica_app/Models/Problem.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  Problem problem;


  @override
  void initState() { 
    super.initState();
    this.asyncInitState();
  }

  void asyncInitState() async {
    this.problem = await ProblemsService.getRandProblem(Levels.easy);
    setState(() { });
  } 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Fisica App'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 800,
                height: 350,
                padding: EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  elevation: 15,
                  
                  child: this.problem.description != "" ? Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                     ListTile(
                                      leading: Icon(Icons.calculate,size: 60, color: Colors.redAccent),
                                      title: Text('Problema nivel ${this.problem.level}',style: TextStyle(fontSize: 30.0)),
                                      subtitle: Text(this.problem.description, style: TextStyle(fontSize: 18.0)),
                                    ),
                                    Text(
                                      'Datos:',
                                      style: TextStyle(
                                          color: Colors.red, fontWeight: FontWeight.bold),
                                    ),
                                    this.problem.time != null
                                        ? Text('Tiempo : ${this.problem.time} m/s')
                                        : Container(),
                                    this.problem.height != null
                                        ? Text('Altura : ${this.problem.height} M')
                                        : Container(),
                                    this.problem.velocity != null
                                        ? Text('Velocidad final : ${this.problem.velocity}')
                                        : Container(),
                                    SizedBox(height: 12),
                                    Text(
                                      'Calcula estos datos y responde :',
                                      style: TextStyle(
                                          color: Colors.red, fontWeight: FontWeight.bold),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: this.createListProblemsForResolve(),
                                    ),
                                    Divider(),
                                    ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.yellow),
                                        onPressed: () {
                                            Navigator.of(context).pushNamed('resolve',arguments: this.problem);
                                        },
                                        icon: Icon(
                                          Icons.calculate,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          'calcular',
                                          style: TextStyle(color: Colors.black),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ) : Text('Hell')
                    //},
                  //),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('- Universidad mariano galvez -'),
                      Text('César Poac Morales '),
                      Text('Ing. Francisco Culajay')

                    ] 
                  )
                ) 
              )
            ]
          ),
        ),
      ),
    );
  }

  void updateStateProblem(Selected selected,int index ){

    setState(() {
      this.problem.valuesToCalculate[index].selected = selected;
    });

  }

  List<Widget> createListProblemsForResolve() {
    print(this.problem);
    
    List<Widget> listProblems = [];
    final calcFreeFall = CalcFreeFall(this.problem);

    for (var i = 0; i < problem.valuesToCalculate.length; i++) {
      final value = problem.valuesToCalculate[i];
        List<Selected> listValuesRandom  = [];
        String nameForCalculate = "";
        switch(value.type) {
          case "height" :
              listValuesRandom = calcFreeFall.createListForHeigthWithValuesRandomAndValueThurt();
              nameForCalculate = "Altura";
          break;
          case "velocity":
              listValuesRandom = calcFreeFall.createListForVelocityWithValuesRandomAndValueThurt();
              nameForCalculate = "Velocidad";
          break;
          case "time" : 
              listValuesRandom = calcFreeFall.createListForTimeWithValuesRandomAndValueThurt();
              nameForCalculate = "Tiempo";
          break;
        }

        Selected valueSelected = this.problem.valuesToCalculate.where((element) => element.type == value.type).first.selected;
        listProblems.add(
          Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(nameForCalculate),
              SizedBox(
                width: 30,
              ),
              DropdownButton(
                  value:  valueSelected != null ? valueSelected :  listValuesRandom[0] ,
                  onChanged: (Selected newValue) {
                      this.updateStateProblem(newValue, i);
                  },
                  items: listValuesRandom.map<DropdownMenuItem<Selected>>((Selected item) {
                            return DropdownMenuItem<Selected>(
                              value: item,
                              child: Text(item.value.toString()),
                            );
                        }).toList()
              )
            ],
          ),
        ));

    }
      return listProblems;
  }
}
