import 'package:flutter/material.dart';
import 'originUsed.dart';
import 'constants.dart';

class ReadingText extends StatelessWidget {
  static const String id = 'readingText';
  CardView card = CardView();
  ReadingText({this.textOutput});
  String textOutput;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.indigo[100],
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              card.cardML(textOutput),
              SizedBox(height: 300.0),

              Container(
                height: 50,
                width: 500,
                child: RaisedButton(
                  shape:RoundedRectangleBorder() ,
                  color:Colors.indigo[300],
                  child: Text(
                    'Go to main page',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Navigator.pop(context),
                  splashColor:Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

