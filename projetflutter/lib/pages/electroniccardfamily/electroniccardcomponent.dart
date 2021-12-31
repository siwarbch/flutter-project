import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/electroniccards.dart';
import 'package:flutter_login_ui/pages/electroniccardfamily/searchelectronic.dart';


import 'package:flutter_login_ui/services/electroniccards_service.dart';

import '../profile_page.dart';

class Electroniccardcoponent extends StatefulWidget {


  @override
  State<Electroniccardcoponent> createState() => _ElectroniccardcoponentState();
}

class _ElectroniccardcoponentState extends State<Electroniccardcoponent> {
  var _cardsNameController = TextEditingController();

  var _cardsQuantityController = TextEditingController();

  var _cardsAcquisitionController = TextEditingController();
  var _editCardsNameController = TextEditingController();

  var _editCardsQuantityController = TextEditingController();

  var _editCardsAcquisitionController = TextEditingController();


  var _electroniccards = Electroniccards();

  var _electroniccardsService = ElectroniccardsService();

  List<Electroniccards> _electroniccardList = <Electroniccards>[];
  var electroniccards;

  @override
  void initState() {

    super.initState();
    getAllElectroniccards();
  }

  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();

  getAllElectroniccards() async {
    _electroniccardList = <Electroniccards>[];
     electroniccards = await _electroniccardsService.readCards();
    electroniccards.forEach((electroniccard) {
      setState(() {
        var electroniccardsModel = Electroniccards();
        electroniccardsModel.name = electroniccard['name'];
        electroniccardsModel.quantity = electroniccard['quantity'];
        electroniccardsModel.acquisitiondate=electroniccard['acquisitiondate'];
        electroniccardsModel.id = electroniccard['id'];

        _electroniccardList.add(electroniccardsModel);
      });
    });
  }
  _editElectroniccards(BuildContext context,electroniccardsid) async{
    electroniccards = await _electroniccardsService.readCardsById(electroniccardsid);
    setState(() {
      _editCardsNameController.text=electroniccards[0]['name']??'No name';
      _editCardsQuantityController.text=electroniccards[0]['quantity']??'No quantity';
      _editCardsAcquisitionController.text=electroniccards[0]['acquisitiondate']?? 'No acquisitiondate ';
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
              _electroniccards.name = _cardsNameController.text;
              _electroniccards.quantity = _cardsQuantityController.text;
              _electroniccards.acquisitiondate = _cardsAcquisitionController.text;


              var result = await _electroniccardsService.saveCards(
                  _electroniccards);

              if(result>0){
                print(result);
                Navigator.pop(context);
                getAllElectroniccards();
                _showSuccessSnackBar(Text('Added Successfully :)'));}


            },
            child: Text("Save"),)
        ],
        title: Text("Electronic Card Form"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _cardsNameController,
                decoration: InputDecoration(
                    hintText: 'Write a name of component',
                    labelText: "Name's Component"
                ),
              ),
              TextField(
                controller: _cardsQuantityController,
                decoration: InputDecoration(
                    hintText: 'Write a quantity in stock',
                    labelText: "Quantity in Stock"
                ),
              ),
              TextField(
                controller: _cardsAcquisitionController,
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
              _electroniccards.id=electroniccards[0]['id'];

              _electroniccards.name = _editCardsNameController.text;
              _electroniccards.quantity = _editCardsQuantityController.text;
              _electroniccards.acquisitiondate = _editCardsAcquisitionController.text;


              var result = await _electroniccardsService.updateCards(
                  _electroniccards);
              if(result>0){
              print(result);
              Navigator.pop(context);
              getAllElectroniccards();
              _showSuccessSnackBar(Text('component updated :)'));}

            },
            child: Text("Update"),)
        ],
        title: Text(" Edit Electronic Card Form"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _editCardsNameController,
                decoration: InputDecoration(
                    hintText: 'Write a name of component',
                    labelText: "Name's Component"
                ),
              ),
              TextField(
                controller: _editCardsQuantityController,
                decoration: InputDecoration(
                    hintText: 'Write a quantity in stock',
                    labelText: "Quantity in Stock"
                ),
              ),
              TextField(
                controller: _editCardsAcquisitionController,
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
  _deleteFormFamilycards(BuildContext context,electroniccardsId) {
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

              var result = await _electroniccardsService.deleteCards(electroniccardsId);
              if(result>0){
                print(result);
                Navigator.pop(context);
                getAllElectroniccards();
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
        title: Text("Electronics cards Family",),




      ),
      body:ListView.builder(
          itemCount:_electroniccardList.length,itemBuilder: (context, index){
            return Padding(
              padding:  EdgeInsets.only(top:8.0,left: 16.0,right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Text(_electroniccardList[index].name?? '\n' ),
                      Text(_electroniccardList[index].quantity??'\n piéces'),

                       IconButton(icon: Icon(Icons.edit, color:Colors.green,),onPressed: (){
                         _editElectroniccards(context, _electroniccardList[index].id);
                       }),
                      IconButton(onPressed: (){
                        _deleteFormFamilycards(context,_electroniccardList[index].id);

                      }, icon: Icon(
                        Icons.delete,
                        color:Colors.red,)),
                    ],
                  ),
                  subtitle: Text(_electroniccardList[index].acquisitiondate??'\n'),

                ),

              ),


            );



      }

      )
      ,

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
                Navigator.push( context, MaterialPageRoute( builder: (context) => Searchelectronic()), );
              },
              child: Icon(Icons.search),),

          ],
        ) ,

    );
  }
}