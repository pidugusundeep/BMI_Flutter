import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speedometer/speedometer.dart';
import 'package:rxdart/rxdart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Healthy Body '),
    );
  }
}

TextEditingController emailController = new TextEditingController();
var txt = new TextEditingController();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _lowerValue = 10.0;
  double _upperValue = 40.0;
  int start = 0;
  int end = 100;

  int counter = 0;

  PublishSubject<double> eventObservable = new PublishSubject();
  @override
  void initState() {
    super.initState();
    const oneSec = const Duration(seconds: 1);
    var rng = new Random();
    new Timer.periodic(oneSec,
        (Timer t) => eventObservable.add(rng.nextInt(59) + rng.nextDouble()));
  }

  Widget inputField(String placeholdername) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: new TextField(
        controller: emailController,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(45.45),
            ),
            borderSide: new BorderSide(
              color: Colors.red,
              width: 3.0,
            ),
          ),
          hintText: placeholdername,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData somTheme = new ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.black,
        backgroundColor: Colors.grey);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
            decoration: BoxDecoration(
                // color: Colors.blueGrey,
                ),
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new SpeedOMeter(
                      start: start,
                      end: end,
                      highlightStart: (_lowerValue / end),
                      highlightEnd: (_upperValue / end),
                      themeData: somTheme,
                      eventObservable: this.eventObservable),
                ),
                inputField('Weight(In Kg)'),
                inputField('Height(In Cms)'),
                new MaterialButton(
                  child: new Text('Check your BMI'),
                  onPressed: () {
                    setState(() {
                      txt.text = emailController.text;
                    });
                  },
                  textColor: Colors.black,
                  color: Colors.blue,
                  padding: const EdgeInsets.only(left: 40, right: 40),
                )
              ],
            )));
  }
}
