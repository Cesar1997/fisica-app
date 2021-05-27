import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class FreeFall extends StatefulWidget {
  const FreeFall({Key key}) : super(key: key);

  @override
  _FreeFallState createState() => _FreeFallState();
}

class _FreeFallState extends State<FreeFall>  with TickerProviderStateMixin{
  var positionY = 0;
  Animation<double> animation;
  AnimationController controller;

  Tween<double> _moveTween = Tween(begin: 0,end : 100);

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
    _moveTween.end = 300;
    return Scaffold(
      appBar: AppBar(
        title: Text('App'),
      ),
      body: Column(
        children: [
          excerciseToResolve(),
          Text("Ejemplo 2"),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent)
              ),
              child: AnimatedBuilder(
                animation: animation,
                builder: (context,snapshot) {
                  return CustomPaint(
                    painter: PainterFreeFall(animation.value),
                    child: Container(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget excerciseToResolve() {
    return Card(

      child: Text(
        'Un balón se deja caer a una altura de 10 metros , con una velocidad',
        style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,),

      ),
    );
  }
}

class PainterFreeFall extends CustomPainter {
  final double positionY ;

  PainterFreeFall(this.positionY){

  }
  @override
  void paint(Canvas canvas, Size size) {
      // TODO: implement paint

      this.drawBall(canvas, size,positionY);

      this.drawTDetailInBall(canvas,size,positionY);

       final pointMode = ui.PointMode.lines;
       final points = [
        Offset(50, 0),
      ];

      points.add(Offset(50, positionY));
      final paint = Paint()
        ..color = Colors.black45
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawPoints(pointMode, points, paint);
      

     print(points.toString()); 

    }
  
    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
      return true;
    }

    void drawBall(Canvas canvas, Size size, double position){
      var paint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;
          canvas.drawCircle(Offset(50,position), 10, paint);
    }

    void drawTDetailInBall(Canvas canvas, Size size, double position){
      final textSpan = TextSpan(
        text: position.toString(),
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
      textPainter.paint(canvas, Offset(60, position));
    }

    void drawPathBall(Canvas canvas,Size size, Path path, double position){
       var paint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill
          ..strokeWidth = 8;

          
          path.lineTo(45, position);
    }
}

