import 'package:flutter/material.dart';
class SmileFace extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 80
            ),
            child: LayoutBuilder(
              builder: (_,constraints) => Container(
                width: constraints.widthConstraints().maxWidth,
                height: constraints.heightConstraints().maxHeight,
                color: Colors.yellow,
                child: CustomPaint(painter: FaceOutlinePainter(),),
              ),
            ),
          ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
      // TODO: implement paint
      final paint = Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = 4.0
          ..color = Colors.indigo;
      //left eye 
      canvas.drawRRect(
        RRect.fromRectAndRadius( Rect.fromLTWH(20, 40, 100, 100), Radius.circular(20) ), 
        paint
      );
      //Right eye 
      canvas.drawOval(Rect.fromLTWH(size.width - 120, 40, 100, 100), paint);

      //Mouth 

      final mouth = Path();
      mouth.moveTo(size.width*0.2, size.height * 0.6);
      mouth.arcToPoint(
        Offset( size.width * 0.8, size.height * 0.6),
        radius : Radius.circular(200),
        clockwise: false
      );
      canvas.drawPath(mouth, paint);
   }
  
    @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    
  }
  
}