import 'package:flutter/material.dart';
import './page.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:math';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

    String muestrePasos = "";
  String _km = "Unknown";
  String _calories = "Unknown";

  String _stepCountValue = 'Unknown';
  StreamSubscription<int> _subscription;

  double _numerox; //numero pasos
  double _convert;
  double _kmx;
  double burnedx;
  double _porciento;
  // double percent=0.1;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    setUpPedometer();
  }

  //inicia codigo pedometer
  void setUpPedometer() {
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int stepCountValue) async {
    // print(stepCountValue); //impresion numero pasos por consola
    setState(() {
      _stepCountValue = "$stepCountValue";
      // print(_stepCountValue);
    });

    var dist = stepCountValue; //pasamos el entero a una variable llamada dist
    double y = (dist + .0); //lo convertimos a double una forma de varias

    setState(() {
      _numerox =
          y; //lo pasamos a un estado para ser capturado ya convertido a double
    });

    var long3 = (_numerox);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(_numerox);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  //function to determine the distance run in kilometers using number of steps
  void getDistanceRun(double _numerox) {
    var distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2)); //dos decimales
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
      //print(_km);
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  //function to determine the calories burned in kilometers using number of steps
  void getBurnedRun() {
    setState(() {
      var calories = _kmx; //dos decimales
      _calories = "$calories";
      //print(_calories);
    });
  }

//Hassan is here
  @override
  Widget build(BuildContext context) {
        //print(_stepCountValue);
    getBurnedRun();
    return new Scaffold(
      appBar: new AppBar(title: new Text("Cal-It"), backgroundColor: Colors.blue,),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: new Text("uzair@hotmail.com"),
              accountName: new Text("UZAIR"),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  child: Image.asset("assets/avatar.png")
                ),
                
                onTap: () => print("This is your current account."),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                image: ExactAssetImage('assets/ProfileBack.png'),
                  fit: BoxFit.fill
                )
              ),
            ),
            new ListTile(
              title: new Text("Page One"),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("First Page")));
              }
            ),
            new ListTile(
              title: new Text("Page Two"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
              }
            ),
            new Divider(),
            new ListTile(
              title: new Text("Cancel"),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: new ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0),
              width: 250, //ancho
              height: 250, //largo tambien por numero height: 300
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment
                        .bottomCenter, //cambia la iluminacion del degradado
                    end: Alignment.topCenter,
                    colors: [Color(0xFFA9F5F2), Color(0xFF01DFD7)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(27.0),
                    bottomRight: Radius.circular(27.0),
                    topLeft: Radius.circular(27.0),
                    topRight: Radius.circular(27.0),
                  )),
                   child: new CircularPercentIndicator(
                  radius: 200.0,
                  lineWidth: 13.0,
                  animation: true,
                  center: Container(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(
                            FontAwesomeIcons.walking,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          //color: Colors.orange,
                          child: Text(
                            '$_stepCountValue',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.purpleAccent),
                          ),
                          // height: 50.0,
                          // width: 50.0,
                        ),
                      ],
                    ),
                  ),
                  percent: 0.217,
                  //percent: _convert,
                  footer: new Text(
                    "Pasos:  $_stepCountValue",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.purple),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purpleAccent,
                ),
            ),
             Divider(
                height: 5.0,
              ),
                            Container(
                width: 80,
                height: 100,
                padding: EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    new Container(
                      child: new Card(
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/distance.png"),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Text(
                            "$_km Km",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ),
                        color: Colors.white54,
                      ),
                    ),
                    VerticalDivider(
                      width: 20.0,
                    ),
                    new Container(
                      child: new Card(
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/burned.png"),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                    VerticalDivider(
                      width: 20.0,
                    ),
                    new Container(
                      child: new Card(
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/step.png"),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 2,
              ),
              Container(
                padding: EdgeInsets.only(top: 2.0),
                width: 150, //ancho
                height: 30, //largo tambien por numero height: 300
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(left: 40.0),
                      child: new Card(
                        child: Container(
                          child: Text(
                            "$_km Km",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                        ),
                        color: Colors.purple,
                      ),
                    ),
                    VerticalDivider(
                      width: 20.0,
                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: new Card(
                        child: Container(
                          child: Text(
                            "$_calories kCal",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                        ),
                        color: Colors.red,
                      ),
                    ),
                    VerticalDivider(
                      width: 5.0,
                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: new Card(
                        child: Container(
                          child: Text(
                            "$_stepCountValue Steps",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                        ),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
    );
  }
}