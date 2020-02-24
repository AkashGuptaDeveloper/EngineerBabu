import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:googlemap/AppModel/HomeModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlemap/NavigationDrawer/NavigationDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:googlemap/GlobalComponent/FlagString.dart';
import 'package:googlemap/GlobalComponent/ColorCode.dart';
//---------------------------------START--------------------------------------//
class HomeScreenDetails extends StatefulWidget {
  final String value1;
  final String value2;
  HomeScreenDetails({Key key,this.value1,this.value2}) : super(key: key);
  @override
  HomeScreenDetailsState createState() => new HomeScreenDetailsState();
}
//--------------------------------HomeScreenState-----------------------------//
class HomeScreenDetailsState extends State<HomeScreenDetails> {
  ScrollController _scrollController = new ScrollController();
//----------------------------_checkInternetConnectivity----------------------//
  void _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlagString.NoInternet, GlobalFlagString.InternetNotConnected);
    }
  }
//---------------------------initState()--------------------------------------//
  @override
  void initState() {
    this._checkInternetConnectivity();
    super.initState();
  }
//-----------------------Widget build-----------------------------------------//
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
//------------------------------------GridListView----------------------------//
    // ignore: non_constant_identifier_names
    final GridListViewDetails = new Container(
      child: new Container(
        child: new Stack(
          alignment: Alignment.topCenter,
            children: <Widget>[
            new SingleChildScrollView(
             child: new Column(
              children: <Widget>[
               new Container(
                 width: MediaQuery.of(context).size.width,
                 margin: EdgeInsets.symmetric(horizontal:0.0),
                 decoration: new BoxDecoration(
                     color: Colors.white
                 ),
               child:Container(
                 height: 500,
                 child: Container(
                     decoration: new BoxDecoration(
                         image: new DecorationImage(
                           image: new NetworkImage(widget.value2.toString()),
                           fit: BoxFit.contain,
                         )
                     )
                 ),
               ),
               ),
                SizedBox(height: 5.0,),
                new Container(
                  color: ColorCode.WhiteColorCode,
                  child: Text(
                    widget.value1.toString(),textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 15.0,color:ColorCode.AppColorCode,fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
              ),
             ),
            ],
        ),
      ),
    );
//------------------------------------WillPopScope----------------------------//
    return Scaffold(
        drawer: _drawer(),
        appBar: new AppBar(
          backgroundColor: ColorCode.AppColorCode,
          iconTheme: new IconThemeData(color: Colors.white),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.value1.toString().toUpperCase(),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
              maxLines: 3, style: TextStyle(fontFamily: GlobalFlagString.Raleway.toString(), fontSize: 14, color: ColorCode.WhiteColorCode, fontWeight: FontWeight.w500,),),
            ],
          ),
          centerTitle: true,
        ),
        backgroundColor: ColorCode.WhiteColorCode,
//-----------------------------Body-ShowList-----------------------------------//
        body: new Container(
          height: height,
          child: new ListView(
            padding: new EdgeInsets.all(4.0),
            controller: _scrollController,
            shrinkWrap: true,
            children: <Widget>[
              GridListViewDetails,
            ],
          ),
        ),
      );
  }
//-----------------------------------------AlertDialog------------------------//
  Future<void> _showDialog(title, text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(GlobalFlagString.InternetWarning,
            textAlign: TextAlign.center, style: new TextStyle(fontSize: 15.0,
                color: ColorCode.AppIcon, fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(title.toString(), textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 12.0, color: ColorCode.AppIcon,
                      fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                _dismissDialog();
                Navigator.of(context);
              },
              child: Text(GlobalFlagString.Ok, style: new TextStyle(
                  fontSize: 15.0, color: ColorCode.AppIcon,
                  fontWeight: FontWeight.bold),),
            ),
          ],
        );
      },
    );
  }
//-------------------------------_dismissDialog-------------------------------//
  _dismissDialog() {
    Navigator.pop(context);
  }
//----------------------------Widget _drawer----------------------------------//
  Widget _drawer() {
    return new Drawer(
      elevation: 20.0,
      child: NavigationDrawer(),
    );
  }
}
//---------------------END----------------------------------------------------//