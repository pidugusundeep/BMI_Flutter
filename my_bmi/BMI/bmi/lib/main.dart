import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Make yourself fit'),
    );
  }
}

TextEditingController weight = new TextEditingController();
TextEditingController height = new TextEditingController();
TextEditingController txt = new TextEditingController();

String bmi = "😀";
String status = "Be Healthy";
String image = "assets/images/normalWeight.png";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   Widget inputField(String placeholdername, controlName) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: new TextField(
        keyboardType: TextInputType.number,
        controller: controlName,
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
                inputField('Weight (In Kg)', weight),
                inputField('Height (In Cms)', height),
                new MaterialButton(
                  child: new Text('Check your BMI'),
                  onPressed: () {
                    setState(() {
                      var  Weight = double.parse(weight.text);
                      var  Height = double.parse(height.text);

                      var finalBMI = (Weight)/((Height/100)*(Height/100));

                      if(finalBMI <18.5){
                        status = "Under Weight";
                        image = "assets/images/underWeight.png";
                      }
                      else if(finalBMI < 24.9){
                        status = "Normal Weight";
                        image = "assets/images/normalWeight.png";
                      }
                      else if(finalBMI < 29.9){
                        status = "Over Weight";
                        image = "assets/images/OverWeight.png";
                      }
                      else{
                        status = "Obesity";
                        image = "assets/images/Obesity.png";
                      }
                      bmi = finalBMI.toInt().toString();
                    });
                  },
                  textColor: Colors.black,
                  color: Colors.blue,
                  padding: const EdgeInsets.only(left: 40, right: 40),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Image.asset("$image"),
                    ),
                    new Expanded(
                        child: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Text(
                              // controller : txt,
                              "BMI : $bmi",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                           
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Container(
                              width: 165.0,
                              child: Text(
                                "$status",
                                style: TextStyle(
                                fontSize: 23,
                              ),
                              ),
                              
                            ),
                            // new Text(
                            //   "$status",
                            //   maxLines :2,
                            // //  overflow: TextOverflow.ellipsis,
                            //   style: TextStyle(
                            //     fontSize: 30,
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ))
                  ],
                )
              ],
            )));
  }
}
