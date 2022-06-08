import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'firstpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MaterialApp(
    home: new MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new FirstRoute(),
        title: new Text('Welcome for Skin Cancer Detection App. ',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
        image: new Image.asset('images/logo.png'),
        backgroundColor: Colors.lightBlueAccent[200],
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 200.0,
        loaderColor: Colors.red);   
  }}
