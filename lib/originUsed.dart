import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'readingText.dart';
import 'classification.dart';

class WholeProject extends StatefulWidget {
  static const String id = 'WholeProject';
  @override
  _WholeProjectState createState() => _WholeProjectState();
}

class _WholeProjectState extends State<WholeProject> {
  File _pickedImage;
  bool isLoaded = false;
  bool isCountPassed = false;
  int count = 0;

  // Reading image
  List<String> textLines;
  String textOutput;

  //classification
  List<String> labelOutput;
  List<String> itemsOutput;
  String item0;
  String item1;
  String item2;

  Future getImageCamera() async {
    final takeImage = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(takeImage.path);
      isLoaded = true;
    });
  }

  Future getImageGallery() async {
    final takeImage = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = File(takeImage.path);
      isLoaded = true;
    });
  }

  Future readText() async {
    FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(_pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(visionImage);
    textLines = [];
    setState(() {});
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        /*for (TextElement word in line.elements) {
          textLines.add(word.text);
        }*/

        textLines.add(line.text);
        //recognizeText.close();
      }

      //print(textLines.join(" ")); // show result in console

    }

    textOutput = textLines.join(" ");
  }

  Future labeling() async {
    FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(_pickedImage);
    final ImageLabeler labeler = FirebaseVision.instance
        .imageLabeler(ImageLabelerOptions(confidenceThreshold: 0.50));
    final List<ImageLabel> labels = await labeler.processImage(visionImage);
    labelOutput = [];

    for (ImageLabel label in labels) {
      labelOutput.add(
          'Object type: ${label.text} \n Confidence: ${((label.confidence.toDouble() * 100).toStringAsFixed(1))}% \n');
    }
    print(labelOutput);
    itemsOutput = labelOutput.take(3).toList();
    item0 = itemsOutput[0];
    item1 = itemsOutput[1];
    item2 = itemsOutput[2];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor:Colors.indigo[100],

        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 200.0),

                    Container(
                      child: RaisedButton(
                        shape:RoundedRectangleBorder() ,
                        splashColor:Colors.blueGrey,
                        child: Text(
                          'Gallery',
                          style: TextStyle(fontSize: 28, color: Colors.black),
                        ),
                        color: Colors.indigo[300],
                        onPressed: () {
                          getImageGallery();
                        },
                      ),
                    ),
                    SizedBox(width: 40.0),
                    RaisedButton(
                      shape:RoundedRectangleBorder() ,
                      splashColor: Colors.blueGrey,
                      child: Text(
                        'Camera',
                        style: TextStyle(fontSize: 28, color: Colors.black),
                      ),
                      color: Colors.indigo[300],
                      onPressed: () {
                        getImageCamera();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                isLoaded
                    ? Center(
                        child: Container(
                          height: 200.0,
                          width: 600.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(_pickedImage),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        child: Text(
                          'Image not selected',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                SizedBox(height: 50.0),
                Container(
                  width: 300,
                  child: RaisedButton(
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Get text',
                      style: TextStyle(fontSize: 28, color: Colors.black),
                    ),
                    color: Colors.indigo[300],
                    onPressed: () {
                      readText();
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReadingText(textOutput: textOutput),
                              ));
                        });
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 300,
                  child: RaisedButton(
                    splashColor: Colors.blueGrey,
                    color: Colors.indigo[300],
                    child: Text(
                      'Get picture objects',
                      style: TextStyle(fontSize: 28, color: Colors.black),
                    ),
                    onPressed: () {
                      labeling();

                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Classification(
                                  item0: item0,
                                  item1: item1,
                                  item2: item2,
                                ),
                              ));
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
