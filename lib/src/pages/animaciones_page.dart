import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimacionesPage extends StatelessWidget {
  const AnimacionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  @override
  _CuadradoAnimadoState createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotacion;
  late Animation<double> opacidad;
  late Animation<double> opacidadOut;
  late Animation<double> moverDerecha;
  late Animation<double> agrandar;

  @override
  void initState() {
    // TODO: implement initState
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));

    rotacion = Tween(begin: 0.0, end: (2.0 * Math.pi))
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    opacidad = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0, 0.25, curve: Curves.easeOut)));

    opacidadOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.75, 1.0, curve: Curves.easeOut)));

    moverDerecha = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    agrandar  = Tween(begin: 0.0, end:2.0 ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    controller.addListener(() {
      // print("Statis:${controller.status} ");
      if (controller.status == AnimationStatus.completed) {
        controller.reset();
      }

      // else if (controller.status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
        animation: controller,
        child: _Rectangulo(),
        builder: (context, child) {
           print("Opacidad:${opacidad.value} ");
           print("Rotacion:${rotacion.value} ");
          //  print("Opacidad:${opacidad.status} ");
          return Transform.translate(
            offset: Offset(moverDerecha.value,0),
            child: Transform.rotate(
              angle: rotacion.value,
              child: Opacity(opacity: opacidad.value - opacidadOut.value, child: Transform.scale(
                scale: agrandar.value,
                child: child)),
            ),
          );
        });
  }
}

class _Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.blue),
    );
  }
}
