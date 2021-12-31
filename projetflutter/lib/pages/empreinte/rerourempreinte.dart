

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/empreinte/empreintefamily.dart';

class Retourempreinte extends StatefulWidget {
  const Retourempreinte({Key? key}) : super(key: key);

  @override
  _RetourempreinteState createState() => _RetourempreinteState();
}
class _RetourempreinteState  extends State<Retourempreinte> {
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
            },
            child: Text('Save'),
          ),

        ],
        title: Text('Empreinte Form'),
        content: SingleChildScrollView(
          child: Column(
            children:<Widget> [
              TextField(

                decoration:InputDecoration(
                    hintText: 'Write a FirstName of member',
                    labelText: "First Name"
                ) ,
              ),
              TextField(
                decoration:InputDecoration(
                    hintText: 'Write a LastName of member',
                    labelText: "Last Name"
                ) ,
              ),
              TextField(

                decoration:InputDecoration(
                    hintText: 'Write a CIN of member',
                    labelText: "CIN"
                ) ,
              ),
              TextField(

                decoration:InputDecoration(
                    hintText: 'Write a phone  number of member',
                    labelText: "Phone number"
                ) ,
              ),
              TextField(

                decoration:InputDecoration(
                    hintText: 'Write a Name of component',
                    labelText: "Name's component"
                ) ,
              ),
              TextField(

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
        leading: RaisedButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Empreintefamily())),
        elevation: 0.0,
        child: Icon(Icons.arrow_back),
        color: Colors.grey,),
         title: Text("retour Liste"),
        ),
    floatingActionButton: Row(

    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
    FloatingActionButton(
    onPressed: (){
    _showFormDaialog(context);
    },
    child: Icon(Icons.add),
    ),


    ],
    )
    );
  }


  }