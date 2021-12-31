import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/battery.dart';
import 'package:flutter_login_ui/pages/batteryfamily/searchbattery.dart';

import 'package:flutter_login_ui/services/batterys_service.dart';




import '../profile_page.dart';

class Batterycoponent extends StatefulWidget {


  @override
  State<Batterycoponent> createState() => _BatterycoponentState();
}

class _BatterycoponentState extends State<Batterycoponent> {
  var _NameController = TextEditingController();

  var _QuantityController = TextEditingController();

  var _AcquisitionController = TextEditingController();
  var _editNameController = TextEditingController();

  var _editQuantityController = TextEditingController();

  var _editAcquisitionController = TextEditingController();


  var _battery = Battery();

  var _batteryService = BatteryService();

  List<Battery> _batteryList = <Battery>[];
  var battery;

  @override
  void initState() {

    super.initState();
    getAllbattery();
  }

  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();

  getAllbattery() async {
    _batteryList = <Battery>[];
    battery = await _batteryService.readCards();
    battery.forEach((battery) {
      setState(() {
        var batteryModel = Battery();
        batteryModel.namebattery = battery['namebattery'];
        batteryModel.quantitybattery = battery['quantitybattery'];
        batteryModel.acquisitiondatebattery=battery['acquisitiondatebattery'];
        batteryModel.id = battery['id'];

        _batteryList.add(batteryModel);
      });
    });
  }
  _editElectroniccards(BuildContext context,batteryId) async{
    battery = await _batteryService.readCardsById(batteryId);
    setState(() {
      _editNameController.text=battery[0]['namebattery']??'No name';
      _editQuantityController.text=battery[0]['quantitybattery']??'No quantity';
      _editAcquisitionController.text=battery[0]['acquisitiondatebattery']?? 'No acquisitiondate ';
    });
    _editFormFamilycards(context);
  }

  _showFormFamilycards(BuildContext context) {
    return showDialog(
        context: context, barrierDismissible: true, builder: (param) {
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            color: Colors.red,
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),),
          FlatButton(
            color: Colors.blue,
            onPressed: () async {
              _battery.namebattery = _NameController.text;
              _battery.quantitybattery = _QuantityController.text;
              _battery.acquisitiondatebattery = _AcquisitionController.text;


              var result = await _batteryService.saveCards(
                  _battery);

              if(result>0){
                print(result);
                Navigator.pop(context);
                getAllbattery();
                _showSuccessSnackBar(Text('Added Successfully :)'));}


            },
            child: Text("Save"),)
        ],
        title: Text("battery  Form"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _NameController,
                decoration: InputDecoration(
                    hintText: 'Write a name of component',
                    labelText: "Name's Component"
                ),
              ),
              TextField(
                controller: _QuantityController,
                decoration: InputDecoration(
                    hintText: 'Write a quantity in stock',
                    labelText: "Quantity in Stock"
                ),
              ),
              TextField(
                controller: _AcquisitionController,
                decoration: InputDecoration(
                    hintText: 'Write a acquisition date',
                    labelText: "Acquisition Date"
                ),
              ),

            ],
          ),
        ),

      );
    });
  }
  _editFormFamilycards(BuildContext context) {
    return showDialog(
        context: context, barrierDismissible: true, builder: (param) {
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            color: Colors.red,
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),),
          FlatButton(
            color: Colors.blue,
            onPressed: () async {
              _battery.id=battery[0]['id'];

              _battery.namebattery = _editNameController.text;
              _battery.quantitybattery = _editQuantityController.text;
              _battery.acquisitiondatebattery = _editAcquisitionController.text;


              var result = await _batteryService.updateCards(
                  _battery);
              if(result>0){
                print(result);
                Navigator.pop(context);
                getAllbattery();
                _showSuccessSnackBar(Text('component updated :)'));}

            },
            child: Text("Update"),)
        ],
        title: Text(" Edit battery Form"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _editNameController,
                decoration: InputDecoration(
                    hintText: 'Write a name of component',
                    labelText: "Name's Component"
                ),
              ),
              TextField(
                controller: _editQuantityController,
                decoration: InputDecoration(
                    hintText: 'Write a quantity in stock',
                    labelText: "Quantity in Stock"
                ),
              ),
              TextField(
                controller: _editAcquisitionController,
                decoration: InputDecoration(
                    hintText: 'Write a acquisition date',
                    labelText: "Acquisition Date"
                ),
              ),

            ],
          ),
        ),

      );
    });
  }
  _showSuccessSnackBar(message){
    var _snackBar= SnackBar(content: message);
    _globalKey.currentState?.showSnackBar(_snackBar);
  }
  _deleteFormFamilycards(BuildContext context,batteryId) {
    return showDialog(

        context: context, barrierDismissible: true, builder: (param) {
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            color: Colors.green,
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),),
          FlatButton(
            color: Colors.red,
            onPressed: () async {

              var result = await _batteryService.deleteCards(batteryId);
              if(result>0){
                print(result);
                Navigator.pop(context);
                getAllbattery();
                _showSuccessSnackBar(Text('component deleted :)'));}

            },
            child: Text("Delete"),)
        ],
        title: Text(" Are you sure you want to delete this ?"),


      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: RaisedButton(onPressed: () =>
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage())),
          child: Icon(Icons.arrow_back), elevation: 0.0,),
        title: Text("Battery's Family",),


      ),
      body:ListView.builder(
          itemCount:_batteryList.length,itemBuilder: (context, index){
        return Padding(
          padding:  EdgeInsets.only(top:8.0,left: 16.0,right: 16.0),
          child: Card(
            elevation: 8.0,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Text(_batteryList[index].namebattery?? '\n' ),
                  Text(_batteryList[index].quantitybattery??'\n piéces'),

                  IconButton(icon: Icon(Icons.edit, color:Colors.green,),onPressed: (){
                    _editElectroniccards(context, _batteryList[index].id);
                  }),
                  IconButton(onPressed: (){
                    _deleteFormFamilycards(context,_batteryList[index].id);

                  }, icon: Icon(
                    Icons.delete,
                    color:Colors.red,)),
                ],
              ),
              subtitle: Text(_batteryList[index].acquisitiondatebattery??'\n'),

            ),
          ),
        );

      }) ,
      floatingActionButton: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _showFormFamilycards(context);
            },
            child: Icon(Icons.add),),
          FloatingActionButton(
            onPressed: () {
              Navigator.push( context, MaterialPageRoute( builder: (context) => Searchbattery()), );
            },
            child: Icon(Icons.search),),

        ],
      ) ,

    );
  }
}