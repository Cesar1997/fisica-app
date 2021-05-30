import 'package:fisica_app/Models/Problem.dart';
import 'package:fisica_app/calculations/FreeFall/CalcFreeFall.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class FreeFall extends StatefulWidget {
  Problem problem;

  @override
  _FreeFallState createState() => _FreeFallState();
}

class _FreeFallState extends State<FreeFall>  with TickerProviderStateMixin{
  var positionY = 0;
  Animation<double> animation;
  AnimationController controller;

  Tween<double> _moveTween = Tween(begin: 0,end : 100);
  Problem problem ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4)
    );

    animation = _moveTween.animate(controller)
    ..addListener(() {
      setState((){});
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        controller.dispose();
      } else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    
     this.problem = ModalRoute.of(context).settings.arguments;
    //this.problem = CalcFreeFall(problem).getProblemResolve();
     final height = CalcFreeFall(problem).calcHeight();
     print(height);
    _moveTween.end = 0;
    _moveTween.end = height;
    controller.duration = Duration(seconds: CalcFreeFall(problem).calcTime().toInt());
    return Scaffold(
      appBar: AppBar(
        title: Text('App'),
      ),
      body: Column(
        children: [
          excerciseToResolve(context),
          Text('Animación caida libre',style: TextStyle(color: Colors.red,fontSize: 20),),
          Expanded(

            child: Container(
              
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              margin: EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                elevation: 15,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context,snapshot) {
                    return CustomPaint(
                      painter: PainterFreeFall( animation.value,height),
                      child: Container(),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget excerciseToResolve( BuildContext context) {
    //final size = BuildContext().
    return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              margin: EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                elevation: 15,
                
                child:  Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(Icons.calculate,
                                  size: 60, color: Colors.redAccent),
                              title: Text('Problema nivel ${this.problem.level}',
                                  style: TextStyle(fontSize: 30.0)),
                              subtitle: Text(this.problem.description,
                                  style: TextStyle(fontSize: 18.0)),
                            ),
                            Text(
                              'Datos:',
                              style: TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.bold,fontSize: 15),
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
                            SizedBox(height: 10),
                            Text('Resultados de prueba', style: TextStyle(color: Colors.red, fontSize: 15,fontWeight: FontWeight.bold)),
                            this._buildDataTable(),
                          ],
                        )
                  //},
                //),
              ),
            )
          ],
        );
  }


  _buildDataTable() {
      return DataTable(
      columns: _columnsDataTable(),
      rows: this.problem.valuesToCalculate.map((e) => _rowTable(e)).toList(),
    );
  }

  
    List<DataColumn> _columnsDataTable() {
    return [
      DataColumn(label: Text('Tipo cálculo')),
      DataColumn(label: Text('Respuesta')),
      DataColumn(label: Text('Resultado')),
      DataColumn(label: Text('Esperado'))
    ];
  }

  DataRow _rowTable(ValuesToCalculate value) {
    //final date = DateTime.fromMillisecondsSinceEpoch(log.timeInMillis);
      String nameForCalculate = "";
      String response = "";
      switch(value.type) {
        case "height" :
            nameForCalculate = "Altura";
            response = value.selected.isResponse ? value.selected.value.toString() : CalcFreeFall(problem).calcHeight().toStringAsFixed(2);
        break;
        case "velocity":
            nameForCalculate = "Velocidad";
            response = value.selected.isResponse ? value.selected.value.toString() : CalcFreeFall(problem).calcVelocity().toStringAsFixed(2);
        break;
        case "time" : 
            nameForCalculate = "Tiempo";
            response = value.selected.isResponse ? value.selected.value.toString() : CalcFreeFall(problem).calcTime().toStringAsFixed(2);
        break;
      }
      Icon iconFlag = value.selected.isResponse ? Icon(Icons.check,color: Colors.green) : Icon(Icons.cancel,color: Colors.red);
    return DataRow(cells: [
      DataCell(Text(nameForCalculate,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
      DataCell(Text(value.selected.value.toString())),
      DataCell( iconFlag ),
      DataCell(Text(response))
    ]);
  }
}





class PainterFreeFall extends CustomPainter {
  Paint _paint ;
  final double positionY ;
  final double height;
  PainterFreeFall(this.positionY, this.height){
      _paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

  }
  @override
  void paint(Canvas canvas, Size size) {
      // TODO: implement paint
         final regla = Paint()
                      ..color = Colors.black26
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke;
        Path path = Path();
          // Draws a line from left top corner to right bottom
          path.moveTo(80, 0);
          
          
          
          for (double i = size.height; i >= 0 ; i--) {
            print("abajo : ${i}");
            path.lineTo(80, i);

            if(i % 50 == 0){
                final textSpan = TextSpan(
                text: "${ (size.height - i)} mts",
                style: TextStyle(
                  
                  color: Colors.black,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  
                ),
              );
              final textPainter = TextPainter(
                textAlign: TextAlign.right,
                text: textSpan,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(
                minWidth: 0,
                maxWidth: size.width,
              );
              textPainter.paint(canvas, Offset(39, i));

              
            }
          }

          print("Posicion ${positionY}");
  
          canvas.drawPath(path, regla);

          this.drawBall(canvas, size,positionY);

          this.drawTDetailInBall(canvas,size,positionY);

       final pointMode = ui.PointMode.lines;
       final points = [
        Offset(100, 0),
      ];

      points.add(Offset(100, positionY));
     
      canvas.drawPoints(pointMode, points, _paint);
      

    }
  
    @override
    bool shouldRepaint(PainterFreeFall oldDelegate) {
      return oldDelegate?.positionY != positionY;
    }

    void drawBall(Canvas canvas, Size size, double position){
      var paint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;
          canvas.drawCircle(Offset(100,position), 10, paint);
    }

    void drawTDetailInBall(Canvas canvas, Size size, double position){
      final textSpan = TextSpan(
        text: "Altura : ${( this.height - position  ).toStringAsFixed(2)} ",
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainter.paint(canvas, Offset(110, position));
    }

    void drawPathBall(Canvas canvas,Size size, Path path, double position){
       var paint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill
          ..strokeWidth = 8;

          
          path.lineTo(100, position);
    }
}

