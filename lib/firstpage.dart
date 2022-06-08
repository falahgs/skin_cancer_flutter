import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:io';
class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}
class _FirstRouteState extends State<FirstRoute> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent[100], 
        appBar: AppBar(
          title: new Text(
            'Skin Cancer Detection',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              tooltip: 'Exit',
              onPressed: () {
                exit(0);
              },
            ), 
            
          ],
          backgroundColor: Colors.lightBlueAccent,
         
          centerTitle: true,
          toolbarHeight: 40,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10.00,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blueAccent[100],
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: ElevatedButton(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(50)),
                image: DecorationImage(
                  image: AssetImage("images/skin_cancer.png"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 10,
                    blurRadius: 7,
                    offset: Offset(0, 1), 
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ),  
       
      ),
    );
  }
}


