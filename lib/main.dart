import 'package:googlemap/SplashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googlemap/GlobalComponent/ColorCode.dart';
//---------------------------------main---------------------------------------//
void main() => runApp(new MyApp());
Map<int, Color> color =
{
  50:Color.fromRGBO(0,84,165, .1),
  100:Color.fromRGBO(0,84,165, .2),
  200:Color.fromRGBO(0,84,165, .3),
  300:Color.fromRGBO(0,84,165, .4),
  400:Color.fromRGBO(0,84,165, .5),
  500:Color.fromRGBO(0,84,165, .6),
  600:Color.fromRGBO(0,84,165, .7),
  700:Color.fromRGBO(0,84,165, .8),
  800:Color.fromRGBO(0,84,165, .9),
  900:Color.fromRGBO(0,84,165, 10),
};
//----------------------------------------------------------------------------//
class MyApp extends StatelessWidget {
//----------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorCode.AppColorCode
    ));
    MaterialColor colorCustom = MaterialColor(0xFF0054A5, color);
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: colorCustom,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
//----------------------------END---------------------------------------------//
