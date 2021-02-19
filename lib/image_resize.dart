import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart';
void resize() {
  // Read an image from file (webp in this case).
  // decodeImage will identify the format of the image and use the appropriate
  // decoder.
 ImageProvider img =  NetworkImage('https://picsum.photos/250?image=9'); //AssetImage('assets/landscape.png')
  Image image = decodeImage(File(img.toString()).readAsBytesSync());

  // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
  Image thumbnail = copyResize(image, width: 120);

  // Save the thumbnail as a PNG.
  File('thumbnail.png')..writeAsBytesSync(encodePng(thumbnail));
}