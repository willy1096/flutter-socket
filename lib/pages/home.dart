import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id:'1',name:'ColdPlay',votes:3),
    Band(id:'2',name:'Metallica',votes:2),
    Band(id:'3',name:'Queen',votes:7),
    Band(id:'4',name:'Santa Fé',votes:4),
  ];
  final textController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Bands',style:TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ) ,
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int i)=>_bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          addNewBand();
        },
        child:Icon(Icons.add),
        elevation: 1,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key:Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        print(direction);
      },
      background: Container(
        child:Text('Eliminando  ${band.name}'),
        color: Colors.redAccent,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent[50],
          child: Text(band.name.substring(0,2)),
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}'),
        onTap: null
      ),
    );
  }


  addNewBand(){
 
    if(Platform.isAndroid){
      return showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            title:Text('New band name'),
            content: TextField(controller: textController,),
            actions: <Widget>[
              MaterialButton(
                onPressed:()=> _addBandToList(textController.text),
                child: Text('Add'),
              )
            ],
          );
        }
      );  
    }else{
      return showCupertinoDialog(
        context: context,
        builder: (_){
          return CupertinoAlertDialog(
            title:Text('New band name'),
            content: CupertinoTextField(controller: textController,),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: ()=>_addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction:false,
                child: Text('Dismiss'),
                onPressed:()=> Navigator.pop(context)
              ),
            ],
          );
        }
        
      );
    }
    
  }
  
  _addBandToList(String text){
    if(text.length>0){
      setState(() {});
      bands.add( Band(id: DateTime.now().toString(),name: text, votes: 0 ) );
      textController.clear();
    }
    Navigator.pop(context);
  }

}