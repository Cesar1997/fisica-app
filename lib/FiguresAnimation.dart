import 'package:flutter/material.dart';
import 'dart:math' as math;
class FiguresAnimation extends StatefulWidget {

  @override
  _FiguresAnimationState createState() => _FiguresAnimationState();
}

class _FiguresAnimationState extends State<FiguresAnimation>  with TickerProviderStateMixin{
  var _sides = 3.0;
  var _radius = 100.0;
  var _radians = 0.0;

  Animation<double> animation;
  AnimationController controller;

  Tween<double> _rotationTween = Tween(begin: -math.pi,end: math.pi);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    animation = _rotationTween.animate(controller)
    ..addListener(() { 
      setState((){});
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        controller.repeat();
      } else if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
     });
     controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text('Lines')
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context,snapshot) { 
                  return CustomPaint(
                    painter: PolygonPainter(_sides,_radius,animation.value),  
                    child: Container(),              
                  );
                },
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Sides'),
            ),
            Slider(
              value: _sides,
              min : 3.0,
              max:  10.0,
              label: _sides.toInt().toString(),
              divisions: 7,
              onChanged: (value){
                setState(() {
                  _sides = value;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Size'),
            ),
            Slider(
              value: _radius,
              min : 10.0,
              max:  MediaQuery.of(context).size.width / 2,
              onChanged: (value){
                setState(() {
                  _radius = value;
                });
              },
            )
          ],
        )
        
      ),
    );
  }
}

class ShapePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
      

       paintLineWithDrawPath(canvas,size);
        paintLineWithDrawLine(canvas,size);
        paintCircleWithDrawPath(canvas,size);


  }

  paintLineWithDrawLine(Canvas canvas, Size size) {
      var paint = Paint()
        ..color = Colors.orange
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
         //Method 1 for draw line
        Offset startingPoint = Offset(0, size.height / 2);
        Offset endingPoint = Offset(size.width,size.height / 2);
        canvas.drawLine(startingPoint, endingPoint, paint);
  }
  paintLineWithDrawPath(Canvas canvas,Size size) {
     var paint = Paint()
        ..color = Colors.orange
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      var path = Path();
      path.moveTo(0, size.height / 2);
      path.lineTo(size.width, size.height / 2);
      canvas.drawPath(path, paint);
  }

  paintCircleWithDrawCircle(Canvas canvas,Size size) {
    var paint = Paint()
        ..color = Colors.teal
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

        Offset center = Offset(size.width / 2, size.height / 2 );

        canvas.drawCircle(center, 100, paint);
  }

  paintCircleWithDrawPath(Canvas canvas, Size size) {
    var paint = Paint()
        ..color = Colors.greenAccent
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

        var path = Path();
        path.addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: 100
        ));
        canvas.drawPath(path, paint);
  }


  paintToDrawPolygon(Canvas canvas, Size size) {
  
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  } 

}

class PolygonPainter extends CustomPainter {
  final double sides;
  final double radius;
  final double radians;

  PolygonPainter(this.sides, this.radius, this.radians);

  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

      var path = Path();
      var angle = (math.pi * 2) / sides;
      Offset center = Offset(size.width / 2, size.height / 2);

      //Start point (100.0,0.0)
      Offset startPoint = Offset(radius * math.cos(radians), radius * math.sin(radians));
      path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

      for(int i = 1; i <= sides; i++){
        double x= radius * math.cos(radians + angle * i) + center.dx;
        double y = radius * math.sin(radians + angle * i) + center.dy;
        path.lineTo(x, y);
      }

      path.close();
      canvas.drawPath(path, paint);
    }
  
    @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}