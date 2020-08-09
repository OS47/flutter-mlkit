import 'package:flutter/material.dart';


class CardView{

/*  String item;
  CardView({this.item});*/

  Widget cardML(String item){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.indigo[300],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          '$item',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );


  }
}
