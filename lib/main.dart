import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

void main() => runApp(ProjectML());

class ProjectML extends StatefulWidget {
  @override
  _ProjectMLState createState() => _ProjectMLState();
}

class _ProjectMLState extends State<ProjectML> {
  File _pickedImage;
  bool isLoaded = false;
  List<String> textLines;
  var textOutput;

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
    FirebaseVisionImage visionImage  = FirebaseVisionImage.fromFile(_pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(visionImage );
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
    return  textOutput;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        'Gallery',
                        style: TextStyle(fontSize: 28),
                      ),
                      color: Colors.blueGrey,
                      onPressed: () {
                        getImageGallery();
                      },
                    ),
                    RaisedButton(
                      child: Text(
                        'Camera',
                        style: TextStyle(fontSize: 28),
                      ),
                      color: Colors.blueGrey,
                      onPressed: getImageCamera,
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
                  child: Text('Read the image'),
                  onPressed: () =>
                  setState(() {
                    readText();
                  })
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$textOutput',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                     ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
