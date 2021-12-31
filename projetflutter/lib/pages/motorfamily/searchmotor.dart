

import 'package:flutter/material.dart';

import 'package:flutter_login_ui/pages/motorfamily/motorcoponent.dart';

import 'package:flutter_login_ui/services/motors_service.dart';


class Searchmotor extends StatefulWidget {





  @override
  State<Searchmotor> createState() => _SearchmotorState();
}
class _SearchmotorState extends State<Searchmotor> {
  var _motorService = MotorsServicce();
  var keyword ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          leading: RaisedButton(onPressed: () =>
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Motorcoponent())),
            child: Icon(Icons.arrow_back), elevation: 0.0,),
          title: Text("Search electronic component",)
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),labelText: 'keyword'
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }

}