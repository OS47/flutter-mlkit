import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'classification.dart';
import 'readingText.dart';
import 'originUsed.dart';
void main() => runApp(ProjectML());

class ProjectML extends StatefulWidget {
  @override
  _ProjectMLState createState() => _ProjectMLState();
}

class _ProjectMLState extends State<ProjectML> {




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WholeProject.id,
      routes: {
        Classification.id: (context) => Classification(),
        ReadingText.id: (context) => ReadingText(),
        WholeProject.id: (context) => WholeProject(),
      },
    );
  }
}
