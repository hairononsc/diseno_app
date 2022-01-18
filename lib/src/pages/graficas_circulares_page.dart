import 'package:diseno_app/src/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class GraficasCircularesPage extends StatefulWidget {
  GraficasCircularesPage({Key? key}) : super(key: key);

  @override
  _GraficasCircularesPageState createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            porcentaje += 10;
            if (porcentaje > 100) {
              porcentaje = 0;
            }
          });
        },
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
           CustomRadiaProgress(porcentaje: porcentaje),
            CustomRadiaProgress(porcentaje: porcentaje)
        ],),
         Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
           CustomRadiaProgress(porcentaje: porcentaje),
            CustomRadiaProgress(porcentaje: porcentaje)
        ],)
      ],),
    );
  }
}

class CustomRadiaProgress extends StatelessWidget {
  const CustomRadiaProgress({
    required this.porcentaje,
  });

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(4),
      // color: Colors.red,
      child: RadialProgress(
        porcentaje: porcentaje,
        primaryColor: Colors.purple,
        primaryStrokeWidth: 25.0,
       
      ),
  
    );
  }
}
