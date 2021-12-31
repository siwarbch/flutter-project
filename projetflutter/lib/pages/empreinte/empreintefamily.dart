import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/empreinte.dart';
import 'package:flutter_login_ui/pages/electroniccardfamily/searchelectronic.dart';
import 'package:flutter_login_ui/pages/empreinte/rerourempreinte.dart';
import 'package:flutter_login_ui/pages/profile_page.dart';
import 'package:flutter_login_ui/services/empreinte_service.dart';
class Empreintefamily extends StatefulWidget {
  const Empreintefamily({Key? key}) : super(key: key);

  @override
  _EmpreintefamilyState createState() => _EmpreintefamilyState();
}

class _EmpreintefamilyState extends State<Empreintefamily> {
  var _emprientefistnameController = TextEditingController();
  var _emprientelastnameController = TextEditingController();
  var _emprientecinController = TextEditingController();
  var _emprientephonenumberController = TextEditingController();
  var _emprientenamecomponentController = TextEditingController();
  var _emprientequantitycomponentController = TextEditingController();


var _empreinte = Empreinte();
var _empreinteService =EmpreinteService();
List<Empreinte> _empreinteList =  <Empreinte>[];
@override
void initState(){
  super.initState();
  getAllEmpreintes();
}
getAllEmpreintes() async{
  _empreinteList = <Empreinte>[];
  var empreintes = await _empreinteService.readEmpreinte();
  empreintes.forEach((empreinte){
    setState(() {
      var empreinteModel = Empreinte();
      empreinteModel.namemembre=empreinte['namemembre'];
      empreinteModel.prenommembre=empreinte['prenommembre'];
      empreinteModel.cin=empreinte['cin'];
      empreinteModel.numtel=empreinte['numtel'];
      empreinteModel.namecomposant=empreinte['namecomposant'];
      empreinteModel.quantitycomposant=empreinte['quantitycomposant'];
      empreinteModel.id=empreinte['id'];
      _empreinteList.add(empreinteModel);
    });

  });
}


  _showFormDaialog(BuildContext context){
    return showDialog(context: context, barrierDismissible:true,builder: (param)
    {
      return AlertDialog(
        actions:<Widget> [
          FlatButton(
            color: Colors.red,
            onPressed:()=>Navigator.pop(context),
              child: Text('Cancel'),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed:() async {
              _empreinte.namemembre = _emprientefistnameController.text;
              _empreinte.prenommembre = _emprientelastnameController.text;
              _empreinte.cin = _emprientecinController.text;
              _empreinte.numtel =  _emprientephonenumberController.text;
              _empreinte.namemembre =  _emprientenamecomponentController.text;
              _empreinte.quantitycomposant = _emprientequantitycomponentController.text;
              var result = await _empreinteService.saveEmpreinte(_empreinte);
              print(result);


            },
            child: Text('Save'),
          ),

        ],
        title: Text('Empreinte Form'),
        content: SingleChildScrollView(
          child: Column(
            children:<Widget> [
              TextField(
                controller:_emprientefistnameController ,
                decoration:InputDecoration(
                    hintText: 'Write a FirstName of member',
                    labelText: "First Name"
                ) ,
              ),
              TextField(
                controller:_emprientelastnameController ,
                decoration:InputDecoration(
                    hintText: 'Write a LastName of member',
                    labelText: "Last Name"
                ) ,
              ),
              TextField(
                controller:_emprientecinController ,
                decoration:InputDecoration(
                    hintText: 'Write a CIN of member',
                    labelText: "CIN"
                ) ,
              ),
              TextField(
                controller:_emprientephonenumberController ,
                decoration:InputDecoration(
                    hintText: 'Write a phone  number of member',
                    labelText: "Phone number"
                ) ,
              ),
              TextField(
                controller:_emprientenamecomponentController ,
                decoration:InputDecoration(
                    hintText: 'Write a Name of component',
                    labelText: "Name's component"
                ) ,
              ),
              TextField(
                controller:_emprientequantitycomponentController ,
                decoration:InputDecoration(
                    hintText: 'Write a Quantity of component',
                    labelText: "Quantity of component"
                ) ,
              ),

            ],
          ),

        ),


      );

    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage())),
          elevation: 0.0,
          child: Icon(Icons.arrow_back),
        color: Colors.grey,),
        title: Text("Empreinte Liste"),
      ),
      body: ListView.builder(itemCount:_empreinteList.length,itemBuilder: (context,index){
        return Padding(
          padding:  EdgeInsets.only(top: 8.0,left:16.0,right: 16.0 ),
          child: Card(
            elevation:8.0 ,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text(_empreinteList[index].namecomposant??'\n'),
                  Text(' '),
                  Text(_empreinteList[index].namemembre??'\n'),

                  Text(' '),
                  Text(_empreinteList[index].prenommembre??'\n'),
                  Text(' '),
                  Text(_empreinteList[index].numtel??'\n'),
                  Text(' '),
                  Text(' '),
                  Text(_empreinteList[index].quantitycomposant??'\n'),
                ],
              ),
              subtitle: Text(_empreinteList[index].cin??'\n'),
            ),
          ),
        );
      }),

      floatingActionButton: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            onPressed: (){
              _showFormDaialog(context);
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push( context, MaterialPageRoute( builder: (context) => Retourempreinte()), );
            },
            child: Icon(Icons.arrow_back),),

        ],
      ) ,
    );
  }
}
