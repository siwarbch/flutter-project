

import 'package:flutter/material.dart';

import 'package:flutter_login_ui/services/batterys_service.dart';


import 'batterycoponent.dart';

class Searchbattery extends StatefulWidget {





  @override
  State<Searchbattery> createState() => _SearchbatteryState();
}
class _SearchbatteryState extends State<Searchbattery> {
  var _batteryService = BatteryService();
  var keyword ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          leading: RaisedButton(onPressed: () =>
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Batterycoponent())),
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