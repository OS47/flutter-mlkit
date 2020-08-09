import 'package:flutter/material.dart';
import 'constants.dart';

class Classification extends StatelessWidget {
  static const String id = 'classification';
  CardView card = CardView();
  Classification({this.item0, this.item1, this.item2});
  String item0;
  String item1;
  String item2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.indigo[100],
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 10.0),
              card.cardML(item0),
              card.cardML(item1),
              card.cardML(item2),
              SizedBox(height: 80.0),
              Container(
                height: 50,
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

/*
class Classification extends StatefulWidget {
  static const String id = 'classification';

  @override
  _ClassificationState createState() => _ClassificationState();
}

class _ClassificationState extends State<Classification> {
  // Classes objects
  GetImage getImage = GetImage();
  bool isLoaded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Colors.indigo[800]),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              */
/*Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      'Gallery',
                      style: TextStyle(fontSize: 28, color: Colors.black),
                    ),
                    color: Colors.indigo[300],
                    onPressed: () {
                      setState(() {
                        getImage.getImageGallery();

                      });
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      'Camera',
                      style: TextStyle(fontSize: 28, color: Colors.black),
                    ),
                    color: Colors.indigo[300],
                    onPressed: () {
                      setState(() {
                        getImage.getImageCamera();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              isLoaded
                  ? Center(
                      child: Container(
                        height: 200.0,
                        width: 600.0,
                        */ /*
*/
/* decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                                getImage.pickedImage),
                            fit: BoxFit.contain,
                          ),
                        ),*/ /*
*/
/*
                        child: Image.file(
                          getImage.pickedImage,
                        ),
                      ),
                    )
                  : Container(
                      child: Text('Image not selected'),
                    ),
              SizedBox(height: 10.0),
              RaisedButton(
                color: Colors.indigo[300],
                child: Text(
                  'Classification',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                onPressed: () => setState(
                  () {
                    getImage.labeling();
                  },
                ),
              ),*/ /*

              Column(
                children: <Widget>[
                  Text(
                    '${getImage.item0}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${getImage.item1}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${getImage.item2}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              RaisedButton(
                  child: Text('Go to main page'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
*/
