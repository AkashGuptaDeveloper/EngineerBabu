import 'dart:async';
import 'package:googlemap/GlobalComponent/ColorCode.dart';
import 'package:googlemap/GlobalComponent/FlagString.dart';
import 'package:googlemap/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//----------------------------Start--------------------------------------------//
class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}
//----------------------------SplashScreenState-------------------------------//
class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin{
  var _visible = true;
  AnimationController animationController;
  Animation<double> animation;
//----------------------------handleTimeout-----------------------------------//
  void handleTimeout() async {
      Navigator.of(context).push(new MaterialPageRoute(builder: (_) =>
      new HomeScreen()));
  }
//----------------------------startTimeout------------------------------------//
  startTimeout() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, handleTimeout);
  }
//----------------------------initState---------------------------------------//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimeout();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 4),
    );
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    setState(() {
      _visible = !_visible;
    });
  }
//----------------------------Widget build-------------------------------------//
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      // ignore: missing_return
      onWillPop: () async {Future.value(false);},
      child: Scaffold(
        backgroundColor: ColorCode.WhiteColorCode,
        body: Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(20.0),
                child: new Text(
                  GlobalFlagString.DeveloperName.toString(),
                  style: TextStyle(fontSize: 12.0,
                    fontWeight: FontWeight.w600,color: ColorCode.AppColorCode),
                ),
              ),

            ],
          ),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: new AssetImage(
                      "assets/images/logo.jpg"
                  ),
                fit: BoxFit.contain,

              )
          ),
        ),
      ),
    );
  }
}
//----------------------------END--------------------------------------------//
