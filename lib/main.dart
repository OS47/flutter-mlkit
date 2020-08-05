import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(ProjectML());

class ProjectML extends StatefulWidget {
  @override
  _ProjectMLState createState() => _ProjectMLState();
}

class _ProjectMLState extends State<ProjectML> {
  File _pickedImage;
  bool isLoaded = false;
  bool isReadText = false;

  // Reading image
  List<String> textLines;
  var textOutput;

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
    return textOutput;
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
          'Type: ${label.text},Confidence: ${label.confidence.toStringAsFixed(2)} \n');

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
      home: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(color: Colors.indigo[800]),
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        'Gallery',
                        style: TextStyle(fontSize: 28, color: Colors.black),
                      ),
                      color: Colors.indigo[300],
                      onPressed: () {
                        getImageGallery();
                      },
                    ),
                    RaisedButton(
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
                SizedBox(height: 20.0),
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
                    : Container(),
                SizedBox(height: 10.0),
                RaisedButton(
                    child: Text(
                      'Read text',
                      style: TextStyle(fontSize: 28, color: Colors.black),
                    ),
                    color: Colors.indigo[300],
                    onPressed: () => setState(() {
                          readText();
                          isReadText = true;
                        })),
                SizedBox(height: 10.0),
                RaisedButton(
                    color: Colors.indigo[300],
                    child: Text(
                      'Classification',
                      style: TextStyle(fontSize: 28, color: Colors.black),
                    ),
                    onPressed: () => setState(() {
                          labeling();
                          isReadText = false;
                        })),
                SizedBox(height: 20.0),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isReadText
                        ? Text(
                            '$textOutput',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        :
                    /*Text(
                      '$itemsOutput',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),*/
                  Column(
                          children: <Widget>[
                            Text( '$item0'
                                  ,
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                            Text(
                              '$item1',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$item2',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
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
