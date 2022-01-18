import 'package:diseno_app/src/widgets/headers.dart';
import 'package:flutter/material.dart';

class HeadersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Container(color:Colors.white,child: HeaderWaveGradient())
    );
  }
}
