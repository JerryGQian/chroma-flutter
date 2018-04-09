import 'package:flutter/material.dart';
import './cameraPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new InkWell(
        //onTap: () => print("We tapped the page!"),
        child:new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            new Text("Select a filter mode", style: new TextStyle(color: Colors.blueGrey, fontSize: 30.0, fontWeight: FontWeight.bold),),
            new Text("something here"),
            new RaisedButton(textColor: Colors.black,
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CameraExampleHome())),
            )
          ],
        ),
      ),
    );
  }
}