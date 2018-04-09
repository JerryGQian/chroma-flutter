import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/chromaLogo_1024.png');
    var image = new Image(image: assetsImage,width: 100.0, height:30.0);
    return new Container(child: image);
  }
}