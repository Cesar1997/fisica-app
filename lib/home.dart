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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FisicaUmg'),
      ),
      body: Column(
        children: [
          Container(
            width: 500,
            height: 350,
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              elevation: 15,
              child: FutureBuilder(
                  future: ProblemsService.getRandProblem(Levels.easy),
                  builder:
                      (BuildContext context, AsyncSnapshot<Problem> snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.calculate,
                                size: 60, color: Colors.redAccent),
                            title: Text('Problema nivel ${data.level}',
                                style: TextStyle(fontSize: 30.0)),
                            subtitle: Text(data.problem,
                                style: TextStyle(fontSize: 18.0)),
                          ),
                          Text(
                            'Datos:',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          data.time != null
                              ? Text('Tiempo : ${data.time} m/s')
                              : Container(),
                          data.height != null
                              ? Text('Altura : ${data.height} M')
                              : Container(),
                          data.velocity != null
                              ? Text('Velocidad final : ${data.velocity}')
                              : Container(),
                          SizedBox(height: 10),
                          Text(
                            'Pon a prueba tu conocimiento:',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: this.createListProblemsForResolve(data),
                          ),
                          Divider(),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.yellow),
                              onPressed: () {},
                              icon: Icon(
                                Icons.calculate,
                                color: Colors.black,
                              ),
                              label: Text(
                                'calcular',
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> createListProblemsForResolve(Problem problem) {
    return problem.valuesToCalculate.map((e) {
      final calcFreeFall = CalcFreeFall(problem);

      return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(e),
            SizedBox(
              width: 30,
            ),
            DropdownButton(
                onChanged: (Map newValue) {
                  setState(() {});
                },
                items: calcFreeFall.createListForTimeWithValuesRandomAndValueThurt()
                    .map<DropdownMenuItem<Map>>((Map item) {

                  return DropdownMenuItem<Map>(
                    value: item,
                    child: Text(item['value'].toString()),
                  );
                }).toList())
          ],
        ),
      );
      //return DropdownButton(items: items)
    }).toList();
    //TODO : Add logic here list and dropdown
  }
}
