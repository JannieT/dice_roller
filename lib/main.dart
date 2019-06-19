import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice Roller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Random generator = new Random();
  AnimationController controller;
  Animation<double> angle;
  int dice = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: roll,
        child: Center(
          child: RotationTransition(
            turns: angle,
            child: Text(
              dice.toString(),
              style: TextStyle(
                fontSize: 90.0,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void roll() {
    controller.reset();
    controller.forward();
  }

  void onAngle() {
    int frac = angle.value.round() % 5;
    if (frac == 0) {
      dice = 1 + generator.nextInt(6);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    angle = Tween<double>(begin: 0.0, end: 5.0).animate(curve);
    angle.addListener(onAngle);
  }

  @override
  void dispose() {
    angle.removeListener(onAngle);
    controller.dispose();
    super.dispose();
  }
}
