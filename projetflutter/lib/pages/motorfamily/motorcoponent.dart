import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/motor.dart';
import 'package:flutter_login_ui/pages/motorfamily/searchmotor.dart';
import 'package:flutter_login_ui/services/motors_service.dart';
import '../profile_page.dart';

class Motorcoponent extends StatefulWidget {


  @override
  State<Motorcoponent> createState() => _MotorcoponentState();
}

class _MotorcoponentState extends State<Motorcoponent> {
  var _motorNameController = TextEditingController();

  var _motorQuantityController = TextEditingController();

  var _motorAcquisitionController = TextEditingController();
  var _editmotorNameController = TextEditingController();

  var _editmotorQuantityController = TextEditingController();

  var _editmotorAcquisitionController = TextEditingController();


  var _motors = Motor();

  var _motorsService = MotorsServicce();

  List<Motor> _motorList = <Motor>[];
  var motor;

  @override
  void initState() {

    super.initState();
    getAllmotor();
  }

  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();

  getAllmotor() async {
    _motorList = <Motor>[];
    motor = await _motorsService.readmotor();
    motor.forEach((motor) {
      setState(() {
        var motorModel = Motor();
        motorModel.namemotor = motor['namemotor'];
        motorModel.quantitymotor = motor['quantitymotor'];
        motorModel.acquisitiondatemotor=motor['acquisitiondatemotor'];
        motorModel.idmotor = motor['idmotor'];

        _motorList.add(motorModel);
      });
    });
  }
  _editmotor(BuildContext context,id) async{
    motor = await _motorsService.readmotorById(id);
    setState(() {
      _editmotorNameController.text=motor[0]['namemotor']??'No name';
      _editmotorQuantityController.text=motor[0]['quantitymotor']??'No quantity';
      _editmotorAcquisitionController.text=motor[0]['acquisitiondatemotor']?? 'No acquisitiondate ';
    });
    _editFormFamilymotor(context);
  }

  _showFormFamilymotor(BuildContext context) {
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
              _motors.namemotor = _motorNameController.text;
              _motors.quantitymotor = _motorQuantityController.text;
              _motors.acquisitiondatemotor = _motorAcquisitionController.text;


              var result = await _motorsService.savemotor(
                  _motors);

              if(result>0){
                print(result);
                Navigator.pop(context);
                getAllmotor();
                _showSuccessSnackBar(Text('Added Successfully :)'));}


            },
            child: Text("Save"),)
        ],
        title: Text("motor components Form"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _motorNameController,
                decoration: InputDecoration(
                    hintText: 'Write a name of component',
                    labelText: "Name's Component"
                ),
              ),
              TextField(
                controller: _motorQuantityController,
                decoration: InputDecoration(
                    hintText: 'Write a quantity in stock',
                    labelText: "Quantity in Stock"
                ),
              ),
              TextField(
                controller: _motorAcquisitionController,
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
  _editFormFamilymotor(BuildContext context) {
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
              _motors.idmotor=motor[0]['idmotor'];

              _motors.namemotor = _editmotorNameController.text;
              _motors.quantitymotor = _editmotorQuantityController.text;
              _motors.acquisitiondatemotor = _editmotorAcquisitionController.text;


              var result = await _motorsService.updatemotor(
                  _motors);
              if(result>0){
                print(result);
                Navigator.pop(context);
                getAllmotor();
                _showSuccessSnackBar(Text('component updated :)'));}

            },
            child: Text("Update"),)
        ],
        title: Text(" Edit Electronic Card Form"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _editmotorNameController,
                decoration: InputDecoration(
                    hintText: 'Write a name of component',
                    labelText: "Name's Component"
                ),
              ),
              TextField(
                controller: _editmotorQuantityController,
                decoration: InputDecoration(
                    hintText: 'Write a quantity in stock',
                    labelText: "Quantity in Stock"
                ),
              ),
              TextField(
                controller: _editmotorAcquisitionController,
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
  _deleteFormFamilycards(BuildContext context,motorId) {
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

              var result = await _motorsService.deleteCards(motorId);
              if(result>0){
                print(result);
                Navigator.pop(context);
                getAllmotor();
                _showSuccessSnackBar(Text('component deleted :)'));}

            },
            child: Text("Delete"),)
        ],
        title: Text(" Are you sure you want to delete this ?"),


      );
    });
  }

  _showSuccessSnackBar(message){
    var _snackBar= SnackBar(content: message);
    _globalKey.currentState?.showSnackBar(_snackBar);
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
        title: Text("Motors cards Family",),


      ),
      body:ListView.builder(
          itemCount:_motorList.length,itemBuilder: (context, index){
        return Padding(
          padding:  EdgeInsets.only(top:8.0,left: 16.0,right: 16.0),
          child: Card(
            elevation: 8.0,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Text(_motorList[index].namemotor?? '\n' ),
                  Text(_motorList[index].quantitymotor??'\n piéces'),

                  IconButton(icon: Icon(Icons.edit, color:Colors.green,),onPressed: (){
                    _editmotor(context, _motorList[index].idmotor);
                  }),
                  IconButton(onPressed: (){
                    _deleteFormFamilycards(context,_motorList[index].idmotor);

                  }, icon: Icon(
                    Icons.delete,
                    color:Colors.red,)),
                ],
              ),
              subtitle: Text(_motorList[index].acquisitiondatemotor??'\n'),

            ),
          ),
        );

      }) ,

      floatingActionButton: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _showFormFamilymotor(context);
            },
            child: Icon(Icons.add),),
          FloatingActionButton(
            onPressed: () {
              Navigator.push( context, MaterialPageRoute( builder: (context) => Searchmotor()), );
            },
            child: Icon(Icons.search),),

        ],
      ) ,

    );
  }
}