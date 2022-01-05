import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class MyImageView extends StatelessWidget {
  final String? entitityImage;
  final double imageWidth;
  final double imageHeight;

  const MyImageView(
      {Key? key,
      this.entitityImage,
      this.imageWidth = 100,
      this.imageHeight = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List _getImage(String source) {
      return base64.decode(source);
    }

    //"https://via.placeholder.com/100x80"
    return entitityImage == null
        ? Image.network(
            "https://via.placeholder.com/" +
                imageWidth.round().toString() +
                "x" +
                imageHeight.round().toString(),
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.fill)
        : Image.memory(_getImage(entitityImage.toString()),
            width: imageWidth, height: imageHeight, fit: BoxFit.fill);
  }
}
