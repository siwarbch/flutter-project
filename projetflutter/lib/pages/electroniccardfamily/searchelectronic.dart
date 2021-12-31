

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/electroniccardfamily/electroniccardcomponent.dart';
import 'package:flutter_login_ui/services/electroniccards_service.dart';

import '../profile_page.dart';

class Searchelectronic extends StatefulWidget {





  @override
  State<Searchelectronic> createState() => _SearchelectronicState();
}
class _SearchelectronicState extends State<Searchelectronic> {
   var _electronicService = ElectroniccardsService();
   var keyword ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: RaisedButton(onPressed: () =>
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Electroniccardcoponent())),
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