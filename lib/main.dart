/*import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(title: 'title'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Text('TESTING'),
      //appBar: new AppBar(title: new Text(title)),
      drawer: new Drawer(
        elevation: 0.0,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: new ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text('Colors!'),
              decoration: new BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.4),
              ),
            ),
            new ListTile(
              title: new Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}*/

/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  cameras = await availableCameras();
  runApp(new CameraApp());
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = new CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('title')),
      body: new Center(child: new Text('My Page!')),
      drawer: new Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: new ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text('Drawer Header'),
              decoration: new BoxDecoration(
                color: Colors.blue,
              ),
            ),
            new ListTile(
              title: new Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );

    if (!controller.value.initialized) {
      return new Container();
    }
    return new AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: new CameraPreview(controller));

  }
}*/

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import './widgets.dart';
import './landingPage.dart';

class CameraExampleHome extends StatefulWidget {
  //final Userdata userdata = new Userdata();

  @override
  CameraExampleHomeState createState() {
    return new CameraExampleHomeState();
  }
}

IconData cameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw new ArgumentError('Unknown lens direction');
}

class CameraExampleHomeState extends State<CameraExampleHome> {
  bool opening = false;
  CameraController controller;
  String imagePath;

  int mode;
  int cameramode = 1;

  //flutterView.getBitmap();

  @override
  void initState() {

    super.initState();
    controller = new CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize();

  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> headerChildren = <Widget>[];
    final List<Widget> cameraList = <Widget>[];

    final List<Widget> columnChildren = <Widget>[];
    columnChildren.add(new Row(children: headerChildren));


    if (controller == null || !controller.value.initialized) {
      bool b = !controller.value.initialized;
      columnChildren.add(new Text('Tap a camera' + '$b'));
    } else if (controller.value.hasError) {
      columnChildren.add(
        new Text('Camera error ${controller.value.errorDescription}'),
      );
    } else {
      columnChildren.add(
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: new Center(
              child: new AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: new CameraPreview(controller),
              ),
            ),
          ),
        ),
      );
      columnChildren.add(
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: new Center(
              child: new AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: new CameraPreview(controller),
              ),
            ),
          ),
        ),
      );

    }

    /*if (cameras.isEmpty) {
      cameraList.add(const Text('No cameras found'));
    } else {
      for (CameraDescription cameraDescription in cameras) {
        cameraList.add(
          new SizedBox(
            width: 90.0,
            child: new RadioListTile<CameraDescription>(
              title: new Icon(cameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: (CameraDescription newValue) async {
                final CameraController tempController = controller;
                controller = null;
                await tempController?.dispose();
                controller =
                new CameraController(newValue, ResolutionPreset.high);
                await controller.initialize();
                setState(() {});
              },
            ),
          ),
        );
      }
    }*/


    headerChildren.add(new Column(children: cameraList));

    return new Scaffold(
      body: new Column(children: columnChildren),
      drawer: new Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: new ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new LogoWidget(),
            ),
            new ListTile(
              leading: const Icon(Icons.event_seat),
              title: new Text('Red/Green mode'),
              onTap: () {
                mode = 1;
                Navigator.pop(context);
              },
            ),
            new ListTile(
              leading: const Icon(Icons.event_seat),
              title: new Text('Blue/Yellow mode'),
              onTap: () {
                mode = 2;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

    );
  }


}

List<CameraDescription> cameras;

Future<Null> main() async {
  cameras = await availableCameras();
  runApp(new MaterialApp(home: new CameraExampleHome()));
  SystemChrome.setEnabledSystemUIOverlays([]);
}



/*class Userdata {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/userdata.txt');
  }

  Future<File> writeUserdata(int userdata) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$userdata');
  }

  Future<int> readUserdata() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If we encounter an error, return 0
      return 0;
    }
  }
}*/