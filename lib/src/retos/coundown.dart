import 'package:flutter/material.dart';

class CountDownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountDown(),
      ),
    );
  }
}

class CountDown extends StatefulWidget {
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> countAnimation;
  late Animation<double> crecer;
  late Animation<double> crecer2;
  late Animation<double> crecer3;
  late Animation<double> crecer4;
  int count = 3;

  @override
  void initState() {
    // TODO: implement initState

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    countAnimation = Tween(begin: 0.0, end: 4.0).animate(controller);
    crecer = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.easeInOut)));
    crecer2 = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.25, 0.50, curve: Curves.easeInOut)));
    crecer3 = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.50, 0.75, curve: Curves.easeInOut)));
    crecer4 = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.easeInOut)));

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        // controller.reverse();
      }
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
      // child: Text("${4-countAnimation.value.toInt()}"),
      builder: (context, child) {
        return Transform.scale(
          scale: crecer.value < 2.0
              ? crecer.value
              : crecer2.value < 2.0
                  ? crecer2.value
                  : crecer3.value < 2.0
                      ? crecer3.value
                      : crecer4.value,
          child: Text("${4 - countAnimation.value.toInt()}",
            style: TextStyle(fontSize: 34),
          ),
        );
      },
    );
  }
}
