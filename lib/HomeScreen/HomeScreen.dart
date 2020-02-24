import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:googlemap/AppModel/HomeModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlemap/HomeScreen/HomeScreenDetails.dart';
import 'package:googlemap/NavigationDrawer/NavigationDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:googlemap/GlobalComponent/FlagString.dart';
import 'package:googlemap/GlobalComponent/ColorCode.dart';
//---------------------------------START--------------------------------------//
class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}
//--------------------------------HomeScreenState-----------------------------//
class HomeScreenState extends State<HomeScreen> {
  // ignore: non_constant_identifier_names
  String GET_Details_ServiceUrl = GlobalFlagString.BaseUrl.toString();
  ScrollController _scrollController = new ScrollController();
  // ignore: non_constant_identifier_names
  List<HomeModel> _ListFinalResultData = [];
  String status = '';
  String errMessage = GlobalFlagString.ErrorSendData;
  var dataCategory;
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
    this.fetchListData();
  }
//-----------------------Widget build-----------------------------------------//
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
//------------------------------------GridListView----------------------------//
    // ignore: non_constant_identifier_names
    final GridListView = new Container(
      child:Column(
        children: <Widget>[
          GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              ),
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: _ListFinalResultData == null ? 0 : _ListFinalResultData.length,
              itemBuilder: (BuildContext context, i) {
                final a = _ListFinalResultData[i];
                return new Container(
                  child: new GestureDetector(
                    onTap: () {
                      setState(() {
                       a.title.toString();
                       a.imageUrl.toString();
                      });
                      var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new HomeScreenDetails(
                            value1: a.title.toString(),
                            value2: a.imageUrl.toString(),),
                      );
                      Navigator.of(context).push(route);
                    },
                    child: Card(
                      elevation: 5,
                      margin: new EdgeInsets.only(left: 3.0, right: 7.0, top: 5.0, bottom: 5.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding:
                        EdgeInsets.only(left:0.0, right: 0.0,),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new SizedBox(height: 5.0,),
                              Flexible(
                                child: Image.network(
                                  a.imageUrl.toString(),
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                              new SizedBox(height: 5.0,),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text(
                                  a.title,textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 12.0,color:ColorCode.AppColorCode,
                                      fontFamily: GlobalFlagString.Raleway.toString(),
                                  ),
                                ),
                              ),
                              new SizedBox(height: 5.0,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
          )
        ],
      ),
    );
//------------------------------------WillPopScope----------------------------//
    return new WillPopScope(
      onWillPop: () => BackScreen(),
      child: Scaffold(
        drawer: _drawer(),
        appBar: new AppBar(
          backgroundColor: ColorCode.AppColorCode,
          iconTheme: new IconThemeData(color: Colors.white),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(GlobalFlagString.HomeScreen.toString().toUpperCase(),textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Raleway', fontSize: 16, color: ColorCode.WhiteColorCode, fontWeight: FontWeight.w500,),),
            ],
          ),
          centerTitle: true,
        ),
          backgroundColor: Colors.grey[200],
//-----------------------------Body-ShowList-----------------------------------//
        body: new Container(
          height: height,
          child: new ListView(
            padding: new EdgeInsets.all(4.0),
            controller: _scrollController,
            shrinkWrap: true,
            children: <Widget>[
              GridListView,
            ],
          ),
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
//-------------------------------------------------_onBackPressed-------------//
  // ignore: non_constant_identifier_names
  Future<bool> BackScreen() {
    return showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text(GlobalFlagString.Areyousure, style: TextStyle(color:ColorCode.AppIcon,fontFamily: GlobalFlagString.Raleway.toString(),fontSize: 14.0),),
        content: new Text(GlobalFlagString.exitanApp, style: TextStyle(color:ColorCode.AppIcon,fontFamily: GlobalFlagString.Raleway.toString(),fontSize: 14.0),),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: roundedButton(GlobalFlagString.No, const Color(0xFF0054A5), const Color(0xFFFFFFFF),),
          ),
          new GestureDetector(
            onTap: () => exit(0),
            child: roundedButton(GlobalFlagString.Yes, const Color(0xFF0054A5), const Color(0xFFFFFFFF)),
          ),
        ],
      ),
    ) ??
        false;
  }
//---------------------------------------roundedButton------------------------//
  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[BoxShadow(color: const Color(0xFFFFFFFF), offset: Offset(1.0, 6.0), blurRadius: 0.001,),
        ],
      ),
      child: Text(buttonLabel, style: new TextStyle(
          color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),),
    );
    return loginBtn;
  }
//------------------------------------fetchListData---------------------------//
 // ignore: non_constant_identifier_names
  Future<void> fetchListData() async {
    final response = await http.get(GlobalFlagString.BaseUrl.toString());
    try{
      if (response.statusCode == 200) {
        final extractdata = jsonDecode(response.body);
        /*print(GlobalFlagString.Printjsonresp.toString()+"${extractdata.toString()}");*/
        setState(() {
          for (Map i in extractdata) {
            _ListFinalResultData.add(HomeModel.fromJson(i));
          }
        });
      }
    }catch(e){
      //print("No Data Found");
    }
  }
}
//---------------------END----------------------------------------------------//