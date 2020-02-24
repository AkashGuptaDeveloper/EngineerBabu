import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googlemap/GlobalComponent/FlagString.dart';
import 'package:googlemap/GlobalComponent/ColorCode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googlemap/GoogleMap/GoogleMap.dart';
import 'package:googlemap/HomeScreen/HomeScreen.dart';
//-----------------------------------------NavigationDrawer-------------------------------------------------//
class NavigationDrawer extends StatefulWidget {
  @override
  NavigationDrawerState createState() => new NavigationDrawerState();
}
//-----------------------------------------NavigationDrawerState---------------------------------------------//
class NavigationDrawerState extends State<NavigationDrawer> {
  // ignore: non_constant_identifier_names
  var ReciveJsonUSERFullName;
  int ChangeColor;
//-----------------------------------------initState()-----------------------------------------------------//
  @override
  void initState() {
    super.initState();
  }
//-----------------------------------------dispose()-----------------------------------------------------//
  @override
  void dispose() {
    super.dispose();
  }
//-----------------------------------------Widget---------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:new Drawer(
          elevation: 20.0,
          child: new Drawer(
              elevation: 20.0,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    child: UserAccountsDrawerHeader(
                      accountName: Text(GlobalFlagString.ReciveJsonUSERFullName.toString()),
                      accountEmail: new Text(GlobalFlagString.UserEmail.toString()),
                      currentAccountPicture:new CircleAvatar(
                        radius: 50.0,
                        backgroundColor:ColorCode.AppColorCode,
                        backgroundImage:
                        AssetImage(GlobalFlagString.UserImage.toString()),
                      ),
                    ),
                  ),
//----------------------------------------------------DashBoard--------------------------------------------------------------//
                  Container(
                    color: ChangeColor == 1 ? ColorCode.AppColorCode : ColorCode.WhiteColorCode,
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.home, size: 20, color: ChangeColor == 1 ? ColorCode.WhiteColorCode : ColorCode.AppColorCode,),
                          SizedBox(width: 15,),
                          Text(GlobalFlagString.Home.toUpperCase(), style: TextStyle(fontFamily: GlobalFlagString.Raleway.toString(), fontSize: 14, color: ChangeColor == 1 ? ColorCode.WhiteColorCode : ColorCode.AppColorCode, fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      onTap: () {
                        ChnageTapColorDashBoard();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(builder: (_) =>
                        new HomeScreen()));
                      },
                    ),
                  ),
                  Divider(height: 1, thickness: 0.2, color: ColorCode.AppColorCode,),
//----------------------------------------------------Map----------------------//
                  Container(
                    color: ChangeColor == 2 ? ColorCode.AppColorCode : ColorCode.WhiteColorCode,
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.solidNewspaper, size: 20, color: ChangeColor == 2 ? ColorCode.WhiteColorCode : ColorCode.AppColorCode,),
                          SizedBox(width: 15,),
                          Text(GlobalFlagString.Map.toUpperCase(), style: TextStyle(fontFamily: GlobalFlagString.Raleway.toString(), fontSize: 14, color: ChangeColor == 2 ? ColorCode.WhiteColorCode : ColorCode.AppColorCode, fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      onTap: () {
                        ChnageTapColorMockTest();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(builder: (_) =>
                        new MyApp()));
                      },
                    ),
                  ),
                  Divider(height: 1, thickness: 0.2, color: ColorCode.AppColorCode,),
                ],
              )),
        ),
      ),
    );
  }
//--------------------Navigation-Color-Change---------------------------------//
  // ignore: non_constant_identifier_names
  void ChnageTapColorDashBoard() {
    setState(() {
      ChangeColor = 1;
    });
  }
// ignore: non_constant_identifier_names
  void ChnageTapColorMockTest() {
    setState(() {
      ChangeColor = 2;
    });
   }
}
//------------------------------END-------------------------------------------//