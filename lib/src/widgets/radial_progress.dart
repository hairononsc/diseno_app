import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final porcentaje;
  final Color primaryColor;
  final Color secundaryColor;
  final primaryStrokeWidth;
  final secundaryStrokeWidth;

  RadialProgress(
      {@required this.porcentaje,
      this.primaryColor = Colors.blue,
      this.secundaryColor = Colors.transparent,
      @required this.primaryStrokeWidth,
      this.secundaryStrokeWidth = 10.0});
  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double porcentajeAnterior;

  @override
  void initState() {
    // TODO: implement initState
    porcentajeAnterior = widget.porcentaje;
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);

    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: controller,
      // child: ,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MiRadialProgress(
                (widget.porcentaje - diferenciaAnimar) +
                    (diferenciaAnimar * controller.value),
                widget.primaryColor,
                widget.secundaryColor,
                widget.primaryStrokeWidth,
                widget.secundaryStrokeWidth),
          ),
        );
      },
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final porcentaje;
  final Color primaryColor;
  final Color secundaryColor;
  final primaryStrokeWidth;
  final secundaryStrokeWidth;
  _MiRadialProgress(this.porcentaje, this.primaryColor, this.secundaryColor,
      this.primaryStrokeWidth, this.secundaryStrokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    // Circulo completado
    final paint = new Paint()
      ..strokeWidth = secundaryStrokeWidth
      ..color = secundaryColor
      ..style = PaintingStyle.stroke;

    final Offset center = new Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * .5);
    canvas.drawCircle(center, radius, paint);
    // arco

    final paintArco = new Paint()
      ..strokeWidth = primaryStrokeWidth
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    // Parte que debe llenarse
    double arcAngle = 2 * pi * (porcentaje / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
